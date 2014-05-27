require './human_computer_game'
require './human_player_strategy'
require './computer_player_strategy'
require './display'

display = Display.new(Kernel)

HumanComputerGame.new(HumanPlayerStrategy.new(display),
                      ComputerPlayerStrategy.new,
                      display).play
