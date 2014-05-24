require './display'

describe Display do

  it "displays an empty square for the empty board" do
    output = double()
    expect(output).to receive(:puts).with("   1  2  3")
    expect(output).to receive(:puts).with("1         ")
    expect(output).to receive(:puts).with("2         ")
    expect(output).to receive(:puts).with("3         ")
    Display.new(output).display_board(Board.start)
  end

  it "displays a mark in the correct position" do
    output = double()
    expect(output).to receive(:puts).with("   1  2  3")
    expect(output).to receive(:puts).with("1  X      ")
    expect(output).to receive(:puts).with("2         ")
    expect(output).to receive(:puts).with("3         ")
    Display.new(output).display_board(Board.new "X--------")
  end

  it "displays a winning board" do
    output = double()
    expect(output).to receive(:puts).with("   1  2  3")
    expect(output).to receive(:puts).with("1  X      ")
    expect(output).to receive(:puts).with("2  O  X  O")
    expect(output).to receive(:puts).with("3        X")
    Display.new(output).display_board(Board.new "X--OXO--X")
  end
end
