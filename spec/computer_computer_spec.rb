require './computer_player_strategy'
require './game'

describe ComputerPlayerStrategy do

  it "plays against itself" do

    io = double().as_null_object()

    strategy = ComputerPlayerStrategy.new
    #100.times do
    #  expect(Game.new(strategy, strategy, io).play_all!).to_not eq "O"
    #end
  end

end
