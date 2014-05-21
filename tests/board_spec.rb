require 'board'

describe Board do

  describe "#won" do

    it "returns true for all won games" do
      board = Board.new "XXX------" 
			board.won.should eq true
		end
	end
end

