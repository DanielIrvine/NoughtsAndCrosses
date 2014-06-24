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
    
      def call(env)
        
        path = env['PATH_INFO'].split('/')
        return show('') if path.empty? 

        board_str = path.last
        
        return show(translate(:invalid_board), ERROR) if !Board.valid_board_str(board_str)

        game = Game.new(human?(path[1]),
                        human?(path[2]), 
                        board: board_str)
       
        title = translate(:game_title)

        if(!game.game_over? && game.next_player.kind_of?(ComputerPlayer))
          new_board = game.next_player.make_move(game.board)
          next_move = create_link(game, new_board.to_s)
        end
        
        rows = []
        cur_row = []
        cur_col = 0
        game.board.all_indexes.each do |sq|
          cur_row << process_square(sq, game)
          if(cur_row.length == game.board.size)
            rows << cur_row
            cur_row = []
          end
        end

        if game.game_over?
          result = result_text(game)
        else
          next_turn = play_turn_text(game)
        end

        file = File.dirname(__FILE__) + '/game.html.erb'
        page = ERB.new(File.read(file)).result(binding)

        show(page)
      end
      
      def human?(name)
        name==player_type(HumanPlayer)
      end
    
      def process_square(sq, game)
        return game.board.mark_at(sq) if game.board.played?(sq)
        if(!game.game_over? && game.next_player.kind_of?(HumanPlayer))
          game.set_next_human_move(sq)
          board = game.next_player.make_move(game.board)
          link = create_link(game, board.to_s)
          "<a href=\"#{link}\">-</a>"
        else
          "-"
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

      def show(page, status = OK)
        ['200',
         {'Content-Type' => 'text/html'},
         [page] ]
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
