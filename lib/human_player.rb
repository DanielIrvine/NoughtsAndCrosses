require 'player'

class HumanPlayer < Player

  def initialize(display, mark)
    super(mark)
    @display = display
  end

  def make_move(board, opponent)
    board.make_move(@display.get_valid_move(board), @mark) 
  end
end
