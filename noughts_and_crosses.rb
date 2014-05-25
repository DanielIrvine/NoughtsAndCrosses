require './human_computer_game'
require './human_player'
require './display'

display = Display.new(Kernel)
HumanComputerGame.new(HumanPlayer.new(display),
                      HumanPlayer.new(display),
                      display).play
