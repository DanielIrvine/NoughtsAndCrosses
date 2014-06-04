require 'human_player'
require 'computer_player'
require 'game'

class GameBuilder

  def initialize(display)
    @display = display
  end

  def build
    x = build_player('X')
    o = build_player('O')
    board = build_board
    @display.show(board)
    Game.new(x, o, @display, board)
  end

  def build_player(mark)
    if @display.human?(mark)
      HumanPlayer.new(@display, mark)
    else
      ComputerPlayer.new(mark, opponent_of(mark))
    end
  end
  
  def build_board
    if @display.four_by_four?
      Board.with_size(4)
    else
      Board.with_size(3)
    end
  end

  def opponent_of(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
