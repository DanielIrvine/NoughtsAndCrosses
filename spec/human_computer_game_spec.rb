require './human_computer_game'
require 'first_available_space_player'

describe HumanComputerGame do

  let (:x) { FirstAvailableSpacePlayer.new }
  let (:o) { FirstAvailableSpacePlayer.new }

  describe "#play" do

    it "asks the user who is playing first" do
      display = double().as_null_object()
      display.should_receive(:human_first?).and_return(true)
      HumanComputerGame.new(x, o, display).play
    end
    
  end

end
