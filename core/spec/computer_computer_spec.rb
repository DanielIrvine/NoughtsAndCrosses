require 'spec_helper'
require 'computer_player'
require 'game'

module NoughtsAndCrosses
  describe ComputerPlayer, :functional => true do
  
    it 'plays against itself' do
  
      io = double.as_null_object
  
      player_x = ComputerPlayer.new('X', 'O')
      player_o = ComputerPlayer.new('O', 'X')
      # 100.times do
      #  expect(Game.new(player_x, player_o, io).play_turn!).to_not eq 'O'
      # end
    end
  end

end
