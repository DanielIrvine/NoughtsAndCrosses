require 'cli_runner'

describe CLIRunner do

  it 'plays until game over' do
    io = double.as_null_object
    x = FirstAvailableSpacePlayer.new('X')
    o = FirstAvailableSpacePlayer.new('O')
    game = Game.new(x, o, io)
    CLIRunner.new(game).play.game_over?.should eq true
  end
end
