class Player

  attr_reader :mark

	def make_move(board)
	end

  def with_mark(mark)
    @mark = mark
    self
  end
end
