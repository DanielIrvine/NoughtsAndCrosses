require './human_computer_game'

describe HumanComputerGame do

  let (:x) { Player.new("X") }
  let (:o) { Player.new("O") }

  describe "#play" do

    it "asks the user who is playing first" do
      display = double().as_null_object()
      display.should_receive(:human_first?).and_return(true)
      HumanComputerGame.new(x, o, display).play
    end
    
  end

end
