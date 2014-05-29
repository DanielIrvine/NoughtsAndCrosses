require 'board'
require 'display'

class Game

  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize (player_x, player_o, display)
    @board = Board.start
    @player_x = player_x 
    @player_o = player_o 
    @display = display
  end

  def play_turn!
    @board = next_player.make_move(@board, opponent_of(next_player))
    @display.display_board(@board)
    @board
  end
  
  def play_all!
    
    @display.display_board(@board)
    
    while !@board.game_over?
      play_turn!
    end

    @display.display_result(@board)
    @board.winner
  end
    
  def opponent_of(player)
    player == @player_x ? @player_o : @player_x
  end

  def next_player
    @board.played_spaces.length % 2 == 0 ? @player_x : @player_o
  end

end
