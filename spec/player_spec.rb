require 'first_available_space_strategy'
require './player'

describe Player do

  describe "#make_move" do
  
    let (:player) { 
      game = double()
      game.should_receive(:opponent_of).with(anything()).and_return(nil)
      Player.new("X", FirstAvailableSpaceStrategy.new, game)
    }

    it "should make one move" do
      player.make_move(Board.start).available_spaces.length.should eq 8
    end

    it "makes a move for the correct player mark" do
      board = player.make_move(Board.start)
      board.played_spaces.map { |sp| board.mark_at(sp) }.first.should eq "X"
    end
  end
end
