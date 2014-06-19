module NoughtsAndCrosses
  class HumanPlayer
  
    attr_reader :mark
    attr_writer :next_move
  
    def initialize(mark)
      @mark = mark
    end
  
    def make_move(board)
      board.make_move(@next_move, @mark)
    end
  end
end
