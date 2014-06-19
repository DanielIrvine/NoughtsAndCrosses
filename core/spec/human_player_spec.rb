require 'board'
require 'human_player'
require 'spec_helper'

module NoughtsAndCrosses
  describe HumanPlayer do
  
    it 'can make a move' do
      board = Board.with_size(3)
      player = HumanPlayer.new('X')
      player.next_move = 4
      expect(player.make_move(board).mark_at(4)).to eq 'X'
    end
  end
end
