require './display'

describe Display do

  it "displays an empty square for the empty board" do
    output = double()
    expect(output).to receive(:puts).with("         ").exactly(3).times
    Display.new(output).display_board(Board.start)
  end
end
