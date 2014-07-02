require 'board'

module NoughtsAndCrosses
  module Web
    class GameState

      attr_reader :path_segments

      def initialize(path)
        @path_segments = path.split('/')
      end

      def valid?
        @path_segments.length == 3 and Board.valid_board_str(@path_segments[2])
      end

      def empty?
        @path_segments.empty?
      end
    end
  end
end
