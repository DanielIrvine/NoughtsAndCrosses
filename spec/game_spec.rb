require 'spec_helper'
require 'game'
require 'first_available_space_player'
require 'defined_sequence_player'

describe 'Game' do

  let(:io) { double.as_null_object }
  let(:game) do
    player_x = FirstAvailableSpacePlayer.new('X')
    player_o = FirstAvailableSpacePlayer.new('O')
    Game.new(player_x, player_o, io)
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
      play_all_moves(game)
    end

    it 'displays a draw result' do
      expect(io).to receive(:display_result).with("It's a draw!")
      x = DefinedSequencePlayer.new('X', [0, 1, 5, 6, 7])
      o = DefinedSequencePlayer.new('O', [2, 3, 4, 8])
      game = Game.new(x, o, io)
      play_all_moves(game)
    end

    it 'displays a winning message for o' do
      expect(io).to receive(:display_result).with('O wins!')
      x = DefinedSequencePlayer.new('X', [0, 1, 7])
      o = DefinedSequencePlayer.new('O', [3, 4, 5])
      game = Game.new(x, o, io)
      play_all_moves(game)
    end

    it 'displays the board after each move' do
      expect(io).to receive(:display_board).with(anything)
      game.play_all!
    end

  end

  def play_all_moves(game)
    game.play_all! until game.game_over? 
  end
end
