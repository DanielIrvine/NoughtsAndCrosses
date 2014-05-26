require './game'
require './display'

class HumanComputerGame  

  def initialize(human, computer, display)
    @human = human 
    @computer = computer
    @display = display
  end

  def play
    human_first = @display.human_first?
    strategy_x = human_first ? @human : @computer
    strategy_o = human_first ? @computer : @human
    winner = Game.new(strategy_x, strategy_o, @display).play_all!
  end
end
