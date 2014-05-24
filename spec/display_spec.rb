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
  
  it "calculates a position from input 1 2" do
    input = double().as_null_object()
    input.should_receive(:gets).and_return("1 2")
    expect(Display.new(input).get_valid_move(Board.start)).to eq 1
  end
  
  it "calculates a position from input 3 2" do
    input = double().as_null_object()
    input.should_receive(:gets).and_return("3 2")
    expect(Display.new(input).get_valid_move(Board.start)).to eq 7
  end
  
  it "prompts for move repeatedly until one is valid" do
    input = double().as_null_object()
    input.should_receive(:gets).and_return("hello")
    input.should_receive(:gets).and_return("3 2")
    expect(Display.new(input).get_valid_move(Board.start)).to eq 7
  end

  it "does not accept 0 as a valid input" do
    input = double().as_null_object()
    input.should_receive(:gets).and_return("2 0")
    input.should_receive(:gets).and_return("3 2")
    expect(Display.new(input).get_valid_move(Board.start)).to eq 7
  end

  it "does not accept >2 as a valid input" do
    input = double().as_null_object()
    input.should_receive(:gets).and_return("1 4")
    input.should_receive(:gets).and_return("3 2")
    expect(Display.new(input).get_valid_move(Board.start)).to eq 7
  end

  it "prompts user for move" do
    io = double()
    io.should_receive(:puts).with(anything())
    io.should_receive(:gets).and_return("3 2")
    expect(Display.new(io).get_valid_move(Board.start)).to eq 7
  end

  it "displays a winner with player mark X" do
    io = double()
    io.should_receive(:puts).with("X wins!")
    Display.new(io).display_winner(Player.new("X"))
  end

  it "displays a winner with player mark O" do
    io = double()
    io.should_receive(:puts).with("O wins!")
    Display.new(io).display_winner(Player.new("O"))
  end

  describe "#human_first?" do
    let (:io) { double().as_null_object() }

    it "returns true when user provides 'y'" do
      io.should_receive(:gets).and_return("y")
      expect(Display.new(io).human_first?).to eq true
    end

    it "returns false when user provides 'n'" do
      io.should_receive(:gets).and_return("n")
      expect(Display.new(io).human_first?).to eq false
    end

    it "continues to ask until the user provides a valid answer" do
      io.should_receive(:gets).and_return("a", "b", "y")
      expect(Display.new(io).human_first?).to eq true
    end
  end
end
