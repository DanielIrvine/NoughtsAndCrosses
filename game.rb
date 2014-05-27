require './board'
require './display'

class Game

  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize (strategy_x, strategy_o, display)
    @board = Board.start
    best_moves = Hash.new
    @player_x = Player.new("X", strategy_x, self, best_moves)
    @player_o = Player.new("O", strategy_o, self, best_moves)
    @display = display
  end

  def play_turn!
    @board = next_player.make_move @board
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
