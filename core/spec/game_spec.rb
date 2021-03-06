require 'spec_helper'
require 'game'
require 'human_player'
require 'computer_player'

module NoughtsAndCrosses
  describe Game do
  
   it "can create a human and a computer player" do
     game = Game.new(true, false, false)
     expect(game.x.kind_of?(HumanPlayer)).to eq true
     expect(game.o.kind_of?(ComputerPlayer)).to eq true
   end
  
   it "can create two computer players" do
     game = Game.new(false, false, false)
     expect(game.x.kind_of?(ComputerPlayer)).to eq true
     expect(game.o.kind_of?(ComputerPlayer)).to eq true
     expect(game.x.mark).to eq 'X'
     expect(game.o.mark).to eq 'O'
   end
   
   it "creates a board of the right size" do
     game = Game.new(false, false, true)
     expect(game.board.size).to eq 4
   end
  
   it 'can play a two human player game' do
     game = Game.new(true, true, false)
     [0, 3, 1, 4, 2].each do |sq|
       game.set_next_human_move(sq)
       game.play_turn!
     end
     expect(game.game_over?).to eq true
   end
  end
end
