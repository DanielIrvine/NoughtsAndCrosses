class Board

  WINNING_TRIPLETS = [ [0, 1, 2], [3, 4, 5], [6, 7, 8],
	                     [0, 3, 6], [1, 4, 7], [2, 5, 8],
											 [0, 4, 8], [2, 4, 6] ]

	UNPLAYED_SQUARE = '-'

	def initialize(board)
		@board = board
	end

	def self.start
		Board.new "---------"
	end

	def won?

		WINNING_TRIPLETS.each do |triplet|
			return true if (played?(triplet[0]) && squares_equal?(triplet))
		end

		false
	end

  def drawn?
		!won? && !available_spaces?
	end

	def available_spaces?
		@board.split('').any?{ |sq| sq == UNPLAYED_SQUARE }
	end

	def make_move(sq, player_mark)
		new_board = String.new(@board)
		new_board[sq] = player_mark
		Board.new new_board
	end

	def available_spaces
		@board.split('').each_with_index.select{ |sq,i| sq == UNPLAYED_SQUARE}.map{ |p| p[1] }
	end

	def played?(square)
		@board[square] != UNPLAYED_SQUARE
	end

	def squares_equal?(a)
		a.map{ |sq| @board[sq] }.uniq.length == 1
	end

end
