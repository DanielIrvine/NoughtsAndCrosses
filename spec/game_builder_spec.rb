require 'spec_helper'
require 'game_builder'
require 'simplified_string_io'
require 'display'

describe GameBuilder do

  describe '#build' do

    it 'asks if player X and player O are human' do
      str = SimplifiedStringIO.new("y\nn\n")
      display = Display.new(str)
      game = GameBuilder.new(display).build
      expect(game.player_x.instance_of?(HumanPlayer)).to be true
      expect(game.player_o.instance_of?(ComputerPlayer)).to be true
    end

    it 'player X chooses computer and player O chooses human' do
      str = SimplifiedStringIO.new("n\ny\n")
      display = Display.new(str)
      game = GameBuilder.new(display).build
      expect(game.player_x.instance_of?(ComputerPlayer)).to be true
      expect(game.player_o.instance_of?(HumanPlayer)).to be true
    end
  end

end
