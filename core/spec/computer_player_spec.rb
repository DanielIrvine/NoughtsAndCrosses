require 'spec_helper'
require 'computer_player'
require 'human_player'
require 'board'
require 'game'

module NoughtsAndCrosses
  describe ComputerPlayer do
  
    let(:computer) { ComputerPlayer.new('O', 'X') }

    it 'blocks the easiest possible 4x4 win' do
      board = Board.new('XXX-O---O-------')
      expect(computer.make_move(board).mark_at(3)).to eq 'O'
    end
    
    it 'can win a 4x4 game' do
      board = Board.new('XXXOX--O---O----')
      expect(computer.make_move(board).winner).to eq 'O'
    end
    
    it 'can begin a 4x4 game' do
      game = Game.new(false, false, 4)
      game.play_turn!
      expect(game.board.available_spaces.length).to eq 15
    end
  
    it 'should play centre square' do
      board = Board.new('X--------')
      expect(computer.make_move(board).mark_at(4)).to eq 'O'
    end

    it 'should play corner square' do
      board = Board.new('----X----')
      new_board = computer.make_move(board)
      expect((new_board.played_spaces & [0, 2, 6, 8]).length).to eq 1
    end
    
    it 'should block a fork' do
      board = Board.new('X---O---X')
      new_board = computer.make_move(board)
      expect((new_board.played_spaces & [1, 3, 5, 7]).length).to eq 1
    end
    
    it 'should create a fork' do
      board = Board.new('X-O-O---X')
      computer = ComputerPlayer.new('X', 'O')
      expect(computer.make_move(board).mark_at(6)).to eq 'X'
    end

    it 'should play the correct last move' do
      board = Board.new('XOX-O-OXX')
      computer = ComputerPlayer.new('O', 'X')
      expect(computer.make_move(board).mark_at(5)).to eq 'O'
    end
  end
end
