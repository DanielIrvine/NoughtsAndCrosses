require 'spec_helper'
require 'game'
require 'first_available_space_player'

describe 'Game' do

  let(:io) { double.as_null_object }
  let(:x) { FirstAvailableSpacePlayer.new('X') }
  let(:o) { FirstAvailableSpacePlayer.new('O') }
  let(:game) { Game.new(x, o, Board.with_size(3)) }

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
  end

end
