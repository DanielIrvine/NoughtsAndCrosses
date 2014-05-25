require './human_computer_game'
require './player'
require './display'

HumanComputerGame.new(Player.new, Player.new, Display.new(kernel)).play
