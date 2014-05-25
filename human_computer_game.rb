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
    player_x = human_first ? @human : @computer
    player_o = human_first ? @computer : @human
    winner = Game.new(player_x, player_o, @display).play_all!
  end
end
