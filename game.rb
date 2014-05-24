require './board'
require './display'

class Game

	attr_reader :board

	def initialize (player_x, player_o, io)
		@board = Board.start
		@player_x = player_x
		@player_o = player_o
    @io = io
	end

	def play_turn!
    play_one!(@player_x)
    play_one!(@player_o)
    @board
	end

  def play_one!(player)
    @board = player.make_move @board
    @io.display_board(@board)
  end
	
	def play_all!
		while !@board.game_over?
			play_turn!
		end
	end

end
