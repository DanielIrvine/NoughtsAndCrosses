require 'spec_helper'
require 'game'
require 'first_available_space_player'

describe 'Game' do

  let(:io) { double.as_null_object() }
  let(:game) do
    player_x = FirstAvailableSpacePlayer.new('X')
    player_o = FirstAvailableSpacePlayer.new('O') 
    game = Game.new(player_x, player_o, io)
  end

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
      board.played_spaces.map{ |sp| board.mark_at(sp) }.uniq.length.should eq 2
    end

    it 'displays the board after the play is made' do
      expect(io).to receive(:display_board) do |board| 
        board.played_spaces.count == 1 
      end
      
      game.play_turn!
    end
  end

  describe '#play_all' do

    it 'plays untils game over' do
      game.play_all!
      game.board.game_over?.should eq true
    end

    it 'displays the board before play and also after each move' do
      expect(io).to receive(:display_board).with(anything).exactly(8).times
      game.play_all!
    end
  end

end


