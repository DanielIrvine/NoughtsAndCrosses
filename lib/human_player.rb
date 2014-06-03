require 'player'

class HumanPlayer < Player
  def initialize(display, mark)
    super(mark)
    @display = display
  end

  def make_move(board)
    move = @display.prompt_for_move
    return nil if move.nil?
    board.make_move(move, @mark)
  end
end
