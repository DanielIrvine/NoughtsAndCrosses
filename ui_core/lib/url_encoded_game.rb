require 'board'

module NoughtsAndCrosses
  module Web
    class UrlEncodedGame

      def initialize(path)
        @path_segments = path.split('/')
      end

      def valid?
        @path_segments.length == 3 and Board.valid_board_str(@path_segments[2])
      end

      def build
        Game.new(UrlEncodedGame.human?(player_x),
                 UrlEncodedGame.human?(player_o), 
                 board: @path_segments[2])
      end
      
      def player_x
        @path_segments[0]
      end

      def player_o
        @path_segments[1]
      end

      def self.human?(name)
        HumanPlayer.name.end_with?(name)
      end
    
    end
  end
end
