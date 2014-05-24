
describe Player do

	describe "#make_move" do
	
		it "should make one move" do
			Player.new("X").make_move(Board.start).available_spaces.length.should eq 8
		end

		it "makes a move for the correct player mark" do
			board = Player.new("X").make_move(Board.start)
			board.played_spaces.map { |sp| board.mark_at(sp) }.first.should eq "X"
    end
	end
end
