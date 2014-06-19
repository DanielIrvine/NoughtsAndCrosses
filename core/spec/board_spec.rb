require 'spec_helper'
require 'board'

module NoughtsAndCrosses

  describe Board do
  
    describe '#won' do
  
      it 'returns true for all horizontal wins' do
        expect(Board.new('XXX------').won?).to eq true
        expect(Board.new('---XXX---').won?).to eq true
        expect(Board.new('------XXX').won?).to eq true
      end
  
      it 'returns true for all vertical wins' do
        expect(Board.new('X--X--X--').won?).to eq true
        expect(Board.new('-X--X--X-').won?).to eq true
        expect(Board.new('--X--X--X').won?).to eq true
      end
  
      it 'returns true for all diagonal wins' do
        expect(Board.new('X---X---X').won?).to eq true
        expect(Board.new('--X-X-X--').won?).to eq true
      end
  
      it 'returns false for empty board' do
        expect(Board.with_size(3).won?).to eq false
      end
  
      it 'returns true for win for O' do
        expect(Board.new('O--O--O--').won?).to eq true
      end
    end
  
    describe '#played' do
  
      it 'returns false for empty board' do
        expect(Board.with_size(3).played?(0)).to eq false
      end
    end
  
    describe '#drawn' do
  
      it 'returns false for empty board' do
        expect(Board.with_size(3).drawn?).to eq false
      end
  
      it 'return true for full board' do
        expect(Board.new('XXOOOXXXO').drawn?).to eq true
      end
    end
  
    describe '#available_spaces' do
  
      it 'returns nine spaces for empty board' do
        expect(Board.with_size(3).available_spaces).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8]
      end
  
      it 'returns zero spaces for full board' do
        expect(Board.new('XX000XXX0').available_spaces).to eq []
      end
  
      it 'returns three spaces after six moves' do
        expect(Board.new('XX-OO-OX-').available_spaces).to eq [2, 5, 8]
      end
    end
  
    describe '#make_move' do
  
      it 'returns winning board after winning move' do
        expect(Board.new('XX-OO----').make_move(2, 'X').won?).to eq true
      end
  
      it 'does not play already played square' do
        expect(Board.new('X--------').make_move(0, 'O').mark_at(0)).to eq 'X' 
      end
    end
  
    describe 'four_by_four' do
      it 'returns true if there is a win in a row' do
        expect(Board.new('XXXX------------').won?).to eq true
        expect(Board.new('----XXXX--------').won?).to eq true
        expect(Board.new('--------XXXX----').won?).to eq true
        expect(Board.new('------------XXXX').won?).to eq true
      end
    end
  end
end
