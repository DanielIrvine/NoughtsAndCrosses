require './player'

class FirstAvailableSpacePlayer < Player

  def make_move(board)
		board.make_move(board.available_spaces.first, @mark)
  end
end
