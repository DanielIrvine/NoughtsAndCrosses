require 'player'

class HumanPlayer < Player
  def initialize(display, mark)
    super(mark)
    @display = display
  end

  def make_move(board)
    board.make_move(@display.prompt_for_valid_move(board), @mark)
  end
end
