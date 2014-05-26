class Player

  attr_reader :mark
  attr_writer :opponent

	def make_move(board)
	end

  def with_mark(mark)
    @mark = mark
    self
  end

  def is_opponent_of!(other)
    @opponent = other
    other.opponent = self
  end
  
  def make_best_move(board)
    board.make_move(board.available_spaces.first, @mark)
  end

end
