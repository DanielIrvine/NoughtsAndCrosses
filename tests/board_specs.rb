require 'board'

describe Board do

	describe "#won" do

    it "returns true for all horizontal wins" do
			(Board.new "XXX------").won?.should eq true
			(Board.new "---XXX---").won?.should eq true
			(Board.new "------XXX").won?.should eq true
		end
    
		it "returns true for all vertical wins" do
			(Board.new "X--X--X--").won?.should eq true
			(Board.new "-X--X--X-").won?.should eq true
			(Board.new "--X--X--X").won?.should eq true
		end
    
		it "returns true for all diagonal wins" do
			(Board.new "X---X---X").won?.should eq true
			(Board.new "--X-X-X--").won?.should eq true
		end

		it "returns false for empty board" do
		end
	end

end

