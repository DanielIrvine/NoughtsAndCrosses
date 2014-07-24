require 'game'

module NoughtsAndCrosses
  module Web
    class QueryStringGame
      def self.new_game(x, o, size)
        board = '-' * size * size
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
        Game.new(human?(x),
                 human?(o),
                 board: board)
      end

      def self.human?(name)
        HumanPlayer.name.end_with?(name)
      end
    end
  end
end
