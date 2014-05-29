require 'spec_helper'
require 'display'

describe Display do

  it 'displays an empty square for the empty board' do
    str = StringIO.new
    Display.new(str).display_board(Board.start)
    str.rewind
    expect(str.read).not_to include('X')
    expect(str.read).not_to include('O')
  end

  it 'displays a mark in the correct position' do
    str = StringIO.new 
    Display.new(str).display_board(Board.new 'X--------')
    str.rewind
    expect(str.read.scan(/X/).length).to eq 1
  end

  it 'displays a winning board' do
    str = StringIO.new
    Display.new(str).display_board(Board.new 'X--OXO--X')
    str.rewind
    expect(str.read.scan(/X/).length).to eq 3
    str.rewind
    expect(str.read.scan(/O/).length).to eq 2
  end
  
  it 'prompts for move repeatedly until one is valid' do
    str = StringIO.new("hello\n8\n")
    str.read
    expect(Display.new(str).get_valid_move(Board.start)).to eq 7
  end

  it 'does not accept 0 as a valid input' do
    str = StringIO.new("0\n8\n")
    str.read
    expect(Display.new(str).get_valid_move(Board.start)).to eq 7
  end

  it 'does not accept >9 as a valid input' do
    str = StringIO.new("10\n8\n")
    str.read
    expect(Display.new(str).get_valid_move(Board.start)).to eq 7
  end

  it 'prompts user for move' do
    str = StringIO.new('8')
    str.read
    expect(Display.new(str).get_valid_move(Board.start)).to eq 7
  end

  it 'displays a winner with player mark X' do
    str = StringIO.new
    board = Board.new('XXXOO----')
    Display.new(str).display_result(board)
    str.rewind
    expect(str.read).to include 'X wins!'
  end

  it 'displays a winner with player mark O' do
    io = double
    io.should_receive(:puts).with('O wins!')
    board = Board.new('XX-OOOX--')
    Display.new(io).display_result(board)
  end

  it 'displays draw when necessary' do
    io = double
    io.should_receive(:puts).with("It's a draw!")
    board = Board.new('XXOOOXXOX')
    Display.new(io).display_result(board)
  end

  describe '#human_first?' do
    let (:io) { double.as_null_object() }

    it 'returns true when user provides y' do
      io.should_receive(:gets).and_return("y\n")
      expect(Display.new(io).human_first?).to eq true
    end

    it 'returns false when user provides n' do
      io.should_receive(:gets).and_return("n\n")
      expect(Display.new(io).human_first?).to eq false
    end

    it 'continues to ask until the user provides a valid answer' do
      io.should_receive(:gets).and_return("a\n", "b\n", "y\n")
      expect(Display.new(io).human_first?).to eq true
    end
  end
end
