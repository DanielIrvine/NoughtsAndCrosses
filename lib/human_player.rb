require 'player'

class HumanPlayer < Player
  def initialize(display, mark)
    super(mark)
    @display = display
  end

  def make_move(board)
    board.make_move(@display.prompt_for_move, @mark)
  end

  def has_available_move?
    @display.has_available_move?
  end
end
