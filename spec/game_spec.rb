require 'spec_helper'
require 'game'
require 'first_available_space_player'

describe 'Game' do

  let(:io) { double.as_null_object }
  let(:x) { FirstAvailableSpacePlayer.new('X') }
  let(:o) { FirstAvailableSpacePlayer.new('O') }
  let(:game) { Game.new(x, o, io) }

  describe '#new' do
    it 'creates an empty game board' do
      game.board.available_spaces.length.should eq 9
    end
  end

  describe '#play_turn' do

    it 'plays one move' do
      board = game.play_turn!
      board.available_spaces.length.should eq 8
    end

    it 'playing twice plays two different player marks' do
      game.play_turn!
      board = game.play_turn!
      board.played_spaces.map { |sp| board.mark_at(sp) }.uniq.length.should eq 2
    end

    it 'displays the board after the play is made' do
      expect(io).to receive(:display_board) do |board|
        board.played_spaces.count == 1
      end

      game.play_turn!
    end
  end

  describe '#play_all' do

    it 'displays a winning message when game is over' do
      expect(io).to receive(:display_result).with('X wins!')
      game = Game.new(x, o, io, Board.new('XX-------'))
      game.play_all!
    end

    it 'displays a draw result' do
      expect(io).to receive(:display_result).with("It's a draw!")
      game = Game.new(x, o, io, Board.new('XXOOOXXO-'))
      game.play_all!
    end

    it 'displays a winning message for o' do
      expect(io).to receive(:display_result).with('O wins!')
      game = Game.new(x, o, io, Board.new('XXOXO-O--'))
      game.play_all!
    end

    it 'displays the board after each move' do
      expect(io).to receive(:display_board).with(anything)
      game.play_all!
    end
  end
end
