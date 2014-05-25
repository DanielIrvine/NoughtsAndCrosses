require './player'

class HumanPlayer < Player

  def initialize(display)
    @display = display
  end

  def make_move(board)
    board.make_move(@display.get_valid_move(board), @mark) 
  end
end
