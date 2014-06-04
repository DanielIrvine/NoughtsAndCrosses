require 'board'

class Game
  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize(x, o, display, start = Board.with_size(3))
    @board = start
    @player_x = x 
    @player_o = o
    @display = display
  end

  def play_turn!
    return if !next_player.has_available_move?
    @board = next_player.make_move(@board)
    @display.display_board(@board)
    @display.display_result(result_text) if game_over?
    @board
  end

  def next_player
    @board.played_spaces.length.even? ? @player_x : @player_o
  end
  
  def game_over?
    @board.game_over?
  end

  def result_text
    if @board.won?
      board.winner + ' wins!'
    else
      "It's a draw!"
    end
  end
end
