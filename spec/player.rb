class Player

	def make_move(board)
		board.make_move(board.available_spaces.first, "X")
	end
end
