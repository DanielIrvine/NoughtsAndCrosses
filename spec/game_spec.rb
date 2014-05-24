require './game'
require './player'

describe "Game" do

	let(:x) { Player.new("X") }
	let(:o) { Player.new("O") }

	describe "#new" do
		it "creates an empty game board" do
			game = Game.new(x, o)
			game.board.available_spaces.length.should eq 9
		end
	end

	describe "#make_play" do

		it "plays both moves" do
			board = Game.new(x, o).play!
			board.available_spaces.length.should eq 7
		end

		it "plays two different player marks" do
			board = Game.new(x, o).play!
			board.played_spaces.map{ |sp| board.mark_at(sp) }.uniq.length.should eq 2
		end
	end

	describe "#play_all" do

		it "plays untils game over" do
			game = Game.new(x, o)
			game.play_all!
			game.board.game_over?.should eq true
		end
	end
end
