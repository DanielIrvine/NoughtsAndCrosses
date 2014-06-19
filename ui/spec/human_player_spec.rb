require 'human_player'
require 'board'

module NoughtsAndCrosses

  describe HumanPlayer do
  
    it 'uses next_move to get a move on the board' do
  
      board = Board.with_size(3)
      player = HumanPlayer.new('X')
      player.next_move = 5
      expect(player.make_move(board).mark_at(5)).to eq 'X'
    end
    
  end

end
