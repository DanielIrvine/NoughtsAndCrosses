require './human_computer_game'
require './display'

display = Display.new(Kernel)

HumanComputerGame.new(display, Game).play
