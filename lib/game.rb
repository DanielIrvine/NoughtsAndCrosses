require 'board'

class Game
  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize(x, o, display, start = Board.start)
    @board = start
    @player_x = x 
    @player_o = o
    @display = display
  end

  def play_turn!
    next_board = next_player.make_move(@board)
    @board = next_board if !next_board.nil?
    @display.display_board(@board)
    @board
  end

  def play_all!
    play_turn!
    @display.display_result(result_text) if @board.game_over?
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
