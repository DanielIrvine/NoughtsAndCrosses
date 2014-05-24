require './display'

describe Display do

  it "displays an empty square for the empty board" do
    output = double()
    expect(output).to receive(:puts).with("         ").exactly(3).times
    Display.new(output).display_board(Board.start)
  end

  it "displays a mark in the correct position" do
    output = double()
    expect(output).to receive(:puts).with(" X       ")
    expect(output).to receive(:puts).with("         ").exactly(2).times
    Display.new(output).display_board(Board.new "X--------")
  end

  it "displays a winning board" do
    output = double()
    expect(output).to receive(:puts).with(" X       ")
    expect(output).to receive(:puts).with(" O  X  O ")
    expect(output).to receive(:puts).with("       X ")
    Display.new(output).display_board(Board.new "X--OXO--X")
  end
end
