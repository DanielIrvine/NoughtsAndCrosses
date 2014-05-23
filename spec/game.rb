require './board'

class Game

	def initialize (player_x, player_o)
		@last_play = Board.start
		@player_x = player_x
		@player_o = player_o
	end

	def make_play!
		@last_play = @player_x.make_move @last_play
		@last_play = @player_o.make_move @last_play
	end

	def available_spaces
		@last_play.available_spaces		
	end
end
