require 'game'
require 'url_encoded_game'

module NoughtsAndCrosses
  module Web
    class QueryStringGame
      def self.new_game(x, o, size)
        board = '-' * size.to_i * size.to_i
        build(x, o, board)
      end

      def self.next_move(x, o, board, sq)
        game = build(x, o, board)
        if !sq.nil? && !sq.empty?
          game.set_next_human_move(sq.to_i)
        end
        p game.play_turn!
        game
      end

      def self.build(x, o, board)
        Game.new(UrlEncodedGame.human?(x),
                 UrlEncodedGame.human?(o),
                 board: board)
      end
    end
  end
end
