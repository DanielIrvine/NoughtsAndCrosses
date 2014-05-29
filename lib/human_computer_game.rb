require 'human_player'
require 'computer_player'

class HumanComputerGame  

  def initialize(display, game_class)
    @display = display
    @game_class = game_class
  end

  def play
    if @display.human_first?
      player_x = HumanPlayer.new(@display, 'X')
      player_o = ComputerPlayer.new('O', 'X')
    else
      player_x = ComputerPlayer.new('X', 'O')
      player_o = HumanPlayer.new(@display, 'O')
    end
    
    @game_class.new(player_x, player_o, @display).play_all!
  end
end
