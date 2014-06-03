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
    @display.show
    Game.new(x, o, @display)
  end

  def build_player(mark)
    if @display.human?(mark)
      HumanPlayer.new(@display, mark)
    else
      ComputerPlayer.new(mark, opponent_of(mark))
    end
  end

  def opponent_of(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
