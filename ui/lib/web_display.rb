require 'board'
require 'game'
require 'game_strings'
require 'erb'
require 'ostruct'
require 'strings'
require 'game_state'

module NoughtsAndCrosses
  module Web
    class WebDisplay
      
      OK = '200'
      ERROR = '400'
      START_TEMPLATE = 'index.html.erb'
      GAME_TEMPLATE = 'game.html.erb'
      INVALID_BOARD_TEMPLATE = 'invalid_board.html.erb'
    
      def initialize
        @template_dir = File.dirname(__FILE__) + '/../templates/web/'
      end

      def call(env)
      
        route, state = env['PATH_INFO'].split('/', 2).reject(&:empty?)
        case route
        when 'game' then
          game_state = GameState.new(state)
          if game_state.valid?
            show(GAME_TEMPLATE, build_game_binding(game_state.build))
          else
            show(INVALID_BOARD_TEMPLATE, binding, ERROR)
          end
        else
          show(START_TEMPLATE, binding)
        end
      end
      
      def build_state(game)

        if game.game_over?
          result = GameStrings.result_text(game.board)
        else
          next_turn = GameStrings.play_turn_text(game)
        end
        
        old_board = game.board
        new_board = game.play_turn!
        next_move = create_link(game, new_board) if new_board != old_board

        { :result => result,
          :game_over => game.game_over?,
          :next_turn => next_turn,
          :board => build_board_rows(game),
          :new_board => new_board,
          :next_move => next_move }
      end

      def build_game_binding(path)
        OpenStruct.new(build_state(path)).instance_eval{binding}
      end

      def build_board_rows(game)

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

      def process_square(sq, game)
        if game.board.played?(sq)
          { :text => game.board.mark_at(sq) }
        elsif(!game.game_over? && game.next_player.kind_of?(HumanPlayer))
          game.set_next_human_move(sq)
          board = game.next_player.make_move(game.board)
          game.set_next_human_move(nil)
          { :link => create_link(game, board.to_s) }
        end
      end

      def show(page, binding, status = OK)
        [status,
         {'Content-Type' => 'text/html'},
         [ERB.new(File.read(@template_dir + page)).result(binding)] ]
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
