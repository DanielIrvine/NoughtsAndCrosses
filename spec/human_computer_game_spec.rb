require 'spec_helper'
require 'human_computer_game'

describe HumanComputerGame do

  describe "#play" do

    it "asks the user who is playing first" do
      display = double().as_null_object()
      display.should_receive(:human_first?).and_return(true)

      game_class = double
      game_class.should_receive(:new).and_return(double.as_null_object)
      expect(HumanComputerGame.new(display, game_class).play).to eq anything
    end
    
  end

end
