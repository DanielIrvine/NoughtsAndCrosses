require 'spec_helper'
require 'game_builder'
require 'simplified_string_io'
require 'cli_display'

describe GameBuilder do

  describe '#build' do

    it 'asks if player X and player O are human' do
      str = SimplifiedStringIO.new("y\nn\nn\n")
      display = CLIDisplay.new(str)
      game = GameBuilder.new(display).build
      expect(game.player_x.instance_of?(HumanPlayer)).to be true
      expect(game.player_o.instance_of?(ComputerPlayer)).to be true
    end

    it 'player X chooses computer and player O chooses human' do
      str = SimplifiedStringIO.new("n\ny\nn\n")
      display = CLIDisplay.new(str)
      game = GameBuilder.new(display).build
      expect(game.player_x.instance_of?(ComputerPlayer)).to be true
      expect(game.player_o.instance_of?(HumanPlayer)).to be true
    end

    it 'asks for board size' do
      str = SimplifiedStringIO.new("y\ny\ny\n")
      display = CLIDisplay.new(str)
      game = GameBuilder.new(display).build
      expect(game.board.size).to eq 4
    end

    it 'builds a board of 3x3 by default' do
      str = SimplifiedStringIO.new("y\ny\nn\n")
      display = CLIDisplay.new(str)
      game = GameBuilder.new(display).build
      expect(game.board.size).to eq 3
    end
  end

end
