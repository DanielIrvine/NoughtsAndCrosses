require 'board'

class Game
  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize(x, o, start = Board.with_size(3))
    @board = start
    @player_x = x 
    @player_o = o
  end

  def play_turn!
    @board = next_player.make_move(@board)
    @board
  end

  def move_possible?
    next_player.has_available_move?
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
