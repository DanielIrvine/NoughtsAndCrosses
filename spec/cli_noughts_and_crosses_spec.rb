require 'cli_runner'
require 'controller'

describe CLIRunner do

  it 'plays until game over' do
    io = double.as_null_object
    x = FirstAvailableSpacePlayer.new('X')
    o = FirstAvailableSpacePlayer.new('O')
    CLIRunner.new(Controller.new).play.game_over?.should eq true
  end
end
