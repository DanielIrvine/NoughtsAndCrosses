require 'spec_helper'
require 'board'
require 'board_dynamics'

describe Board do

  describe '#won' do

    it 'returns true for all horizontal wins' do
      (Board.new 'XXX------').won?.should eq true
      (Board.new '---XXX---').won?.should eq true
      (Board.new '------XXX').won?.should eq true
    end

    it 'returns true for all vertical wins' do
      (Board.new 'X--X--X--').won?.should eq true
      (Board.new '-X--X--X-').won?.should eq true
      (Board.new '--X--X--X').won?.should eq true
    end

    it 'returns true for all diagonal wins' do
      (Board.new 'X---X---X').won?.should eq true
      (Board.new '--X-X-X--').won?.should eq true
    end

    it 'returns false for empty board' do
      Board.with_size(3).won?.should eq false
    end

    it 'returns true for win for O' do
      (Board.new 'O--O--O').won?.should eq true
    end
  end

  describe '#played' do

    it 'returns false for empty board' do
      Board.with_size(3).played?(0).should eq false
    end
  end

  describe '#drawn' do

    it 'returns false for empty board' do
      Board.with_size(3).drawn?.should eq false
    end

    it 'return true for full board' do
      expect(Board.new('XXOOOXXXO').drawn?).to eq true
    end
  end

  describe '#available_spaces' do

    it 'returns nine spaces for empty board' do
      Board.with_size(3).available_spaces.should eq [0, 1, 2, 3, 4, 5, 6, 7, 8]
    end

    it 'returns zero spaces for full board' do
      (Board.new 'XX000XXX0').available_spaces.should eq []
    end

    it 'returns three spaces after six moves' do
      (Board.new 'XX-OO-OX-').available_spaces.should eq [2, 5, 8]
    end
  end

  describe '#make_move' do

    it 'returns winning board after winning move' do
      (Board.new 'XX-OO----').make_move(2, 'X').won?.should eq true
    end

    it 'does not play already played square' do
      expect((Board.new 'X--------').make_move(0, 'O').mark_at(0)).to eq 'X' 
    end
  end

  describe 'four_by_four' do
    it 'returns true if there is a win in a row' do
      dynamics = BoardDynamics.new(4)
      expect(Board.new('XXXX------------', dynamics).won?).to eq true
      expect(Board.new('----XXXX--------', dynamics).won?).to eq true
      expect(Board.new('--------XXXX----', dynamics).won?).to eq true
      expect(Board.new('------------XXXX', dynamics).won?).to eq true
    end
  end
end
