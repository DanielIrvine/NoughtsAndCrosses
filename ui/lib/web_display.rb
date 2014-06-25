require 'board'
require 'game'
require 'erb'
require 'strings'

module NoughtsAndCrosses
  module Web
    class WebDisplay
      
      include Strings

      OK = '200'
      ERROR = '400'
      TEMPLATE_DIR = File.dirname(__FILE__) + '/../templates/'
      START_TEMPLATE = 'index.html.erb'
      GAME_TEMPLATE = 'game.html.erb'
      INVALID_BOARD_TEMPLATE = 'invalid_board.html.erb'
    
      def call(env)
        
        path = env['PATH_INFO'] 
        return show(START_TEMPLATE, binding) if path.empty? 

        path_parts = path.split('/').reject(&:empty?)
        
        if invalid_path(path_parts)
          return show(INVALID_BOARD_TEMPLATE, binding, ERROR)
        end

        show(GAME_TEMPLATE, build_game_binding(path_parts))
      end
      
      def invalid_path(path_parts)
        path_parts.length != 3 || !Board.valid_board_str(path_parts[2])
      end

      def build_game_binding(path)
        
        game = Game.new(human?(path[0]),
                        human?(path[1]), 
                        board: path[2])

        if game.game_over?
          result = result_text(game)
        else
          next_turn = play_turn_text(game)
        end
        
        rows = build_board_rows_binding(game)
        
        new_board = game.play_turn!
        next_move = create_link(game, new_board)

        binding
      end

      def build_board_rows_binding(game)

        rows = []
        cur_row = []
        game.board.all_indexes.each do |sq|
          cur_row << process_square(sq, game)
          next if cur_row.length != game.board.size

          rows << cur_row
          cur_row = []
        end
        rows
      end

      def next_computer_move(game)
        new_board = game.next_player.make_move(game.board)
        next_move = create_link(game, new_board.to_s)
      end

      def human?(name)
        name==player_type(HumanPlayer)
      end
    
      def process_square(sq, game)
        if game.board.played?(sq)
          { :text => game.board.mark_at(sq) }
        elsif(!game.game_over? && game.next_player.kind_of?(HumanPlayer))
          game.set_next_human_move(sq)
          board = game.next_player.make_move(game.board)
          { :link => create_link(game, board.to_s) }
        end
      end

      def play_turn_text(game)
        if game.next_player.kind_of?(HumanPlayer)
          translate(:human_move, game.next_player.mark)
        else
          translate(:computer_move, game.next_player.mark)
        end
      end

      def result_text(game)
        if game.board.drawn?
          translate(:draw)
        else
          translate(:winner, game.board.winner)
        end
      end

      def show(page, binding, status = OK)
        [status,
         {'Content-Type' => 'text/html'},
         [ERB.new(File.read(TEMPLATE_DIR + page)).result(binding)] ]
      end

      def create_link(game, board_str)
        "/#{player_type(game.x.class)}/#{player_type(game.o.class)}/#{board_str}"
      end

      def player_type(player)
        player.name.split('::').last
      end
    end
  end

end
