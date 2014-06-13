require 'board'
require 'human_player'
require 'computer_player'
require 'strings'

class Game
  include NoughtsAndCrosses::Strings

  attr_reader :board
  attr_reader :x, :o

  def initialize(x_human, o_human, size)
    @x = build_player(translate(:x), x_human)
    @o = build_player(translate(:o), o_human)
    @board = Board.with_size(size)
  end

  def play_turn!
    @board = next_player.make_move(@board)
    @board
  end

  def next_player
    @board.played_spaces.length.even? ? @x : @o
  end
  
  def game_over?
    @board.game_over?
  end

  def set_next_human_move(square)
    next_player.next_move = square if next_player.kind_of?(HumanPlayer)
  end

  def result_text
    if @board.won?
      board.winner + ' wins!'
    else
      "It's a draw!"
    end
  end

  def build_player(mark, human)
    if human
      HumanPlayer.new(mark)
    else
      ComputerPlayer.new(mark, opponent_of(mark))
    end
  end

  def opponent_of(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
