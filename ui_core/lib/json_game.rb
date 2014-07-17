require 'game'
require 'game_strings'
require 'game_state'

module NoughtsAndCrosses
  module Web
    class JsonGame

      attr_reader :result

      def initialize(game)
        @game = game
      end

      def self.make_move_with_params(params, sq)

        game = JsonGame.new(GameState.with_params(params).build)
        game.make_move(sq)
        game
      end

      def self.get_board(params)
        JsonGame.new(GameState.initial_board(params).build)
      end

      def make_move(sq)
        if !sq.nil? && !sq.empty?
          @game.set_next_human_move(sq.to_i)
        end
        @game.play_turn!
      end

      def create_json

        result = { board: @game.board, 
                   finished: @game.game_over?,
                   x: player_name(@game.x),
                   o: player_name(@game.o)}

        if @game.next_player.kind_of?(ComputerPlayer)
          result[:next_move] = 'computer'
        end

        if @game.game_over?
          result[:status_text] = GameStrings.result_text(@game.board)
        else
          result[:status_text] = GameStrings.play_turn_text(@game)
        end

        @result = result

        JSON.generate(result)
      end

      def player_name(player)
        player.class.name.split('::').last
      end
    end
  end
end
