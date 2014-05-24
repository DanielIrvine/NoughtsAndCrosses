require './board'

class Game

	attr_reader :board

	def initialize (player_x, player_o)
		@board = Board.start
		@player_x = player_x
		@player_o = player_o
	end

	def play!
		@board = @player_x.make_move @board
		@board = @player_o.make_move @board
	end
	
	def play_all!
		while !@board.game_over?
			play!
		end
	end

end
