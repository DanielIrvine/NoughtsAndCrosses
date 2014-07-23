require 'board'

module NoughtsAndCrosses
  module Web
    class GameState

      attr_reader :path_segments

      def initialize(path)
        @path_segments = path.split('/')
      end

      def self.with_params(params)
        path_segments = [ params["x"], params["o"], params["board"] ]
        GameState.new(path_segments.join('/'))
      end

      def self.initial_board(params)
        size = params["size"].to_i
        board = '-' * size * size
        path_segments = [ params["x"], params["o"], board]
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
