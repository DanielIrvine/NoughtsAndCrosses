require 'board'

module NoughtsAndCrosses
  module Web
    class GameState

      attr_reader :path_segments

      def initialize(path)
        @path_segments = path.split('/')
      end

      def self.with_request(request)
        path_segments = [ request.params["x"], request.params["o"], request.params["board"] ]
        GameState.new(path_segments.join('/'))
      end

      def valid?
        @path_segments.length == 3 and Board.valid_board_str(@path_segments[2])
      end


      def build
        Game.new(human?(player_x),
                 human?(player_o), 
                 board: @path_segments[2])
      end
      
      def player_x
        @path_segments[0]
      end

      def player_o
        @path_segments[1]
      end

      def human?(name)
        HumanPlayer.name.end_with?(name)
      end
    
    end
  end
end
