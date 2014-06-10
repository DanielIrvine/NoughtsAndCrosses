require 'player'

class HumanPlayer < Player

  attr_writer :next_move

  def initialize(mark)
    super(mark)
  end

  def make_move(board)
    board.make_move(@next_move, @mark)
  end
end
