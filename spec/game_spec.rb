require './game'
require './player'

describe "Game" do

	let(:x) { Player.new("X") }
	let(:o) { Player.new("O") }
  let(:io) { double().as_null_object() }

	describe "#new" do
		it "creates an empty game board" do
			game = Game.new(x, o, io)
			game.board.available_spaces.length.should eq 9
		end
	end

	describe "#make_play" do

		it "plays both moves" do
			board = Game.new(x, o, io).play_turn!
			board.available_spaces.length.should eq 7
		end

		it "plays two different player marks" do
			board = Game.new(x, o, io).play_turn!
			board.played_spaces.map{ |sp| board.mark_at(sp) }.uniq.length.should eq 2
		end

    it "displays the board after the play is made" do
      expect(io).to receive(:display_board) do |board| 
        board.played_spaces.count == 1 
      end
      
      expect(io).to receive(:display_board) do |board| 
        board.played_spaces.count == 2 
      end

      Game.new(x, o, io).play_turn!
    end
	end

	describe "#play_all" do

		it "plays untils game over" do
      game = Game.new(x, o, io)
			game.play_all!
			game.board.game_over?.should eq true
		end

    it "displays the initial board and after each move" do
      expect(io).to receive(:display_board).with(anything()).exactly(8).times
      game = Game.new(x, o, io)
      game.play_all!
    end
	end

end
