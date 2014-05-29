require './human_computer_game'
require './display'
require 'io/console'

display = Display.new(IO.console)

HumanComputerGame.new(display, Game).play
