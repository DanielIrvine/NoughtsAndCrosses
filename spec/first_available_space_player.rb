class FirstAvailableSpacePlayer

  def initialize(mark)
    @mark = mark
  end
  
  def make_move(board, opponent)
    board.make_move(board.available_spaces.first, @mark)
  end
end
