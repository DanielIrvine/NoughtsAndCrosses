require './game'
require './player'

describe "Game" do

	let(:x) { Player.new }
	let(:y) { Player.new }

	describe "#new" do
		it "creates an empty game board" do
			game = Game.new(x, y)
			game.available_spaces.length.should eq 9
		end
	end

	describe "#make_play" do

		let(:game_after_move) { 
			game = Game.new(x, y)
			game.make_play!
			game
		}
		
		it "plays both moves" do
			game_after_move.available_spaces.length.should eq 7
		end

	end
end
