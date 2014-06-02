require 'spec_helper'
require 'simplified_string_io'
require 'display'

describe Display do

  it 'displays an empty square for the empty board' do
    str = SimplifiedStringIO.new
    Display.new(str).display_board(Board.start)
    expect(str.string).not_to include('X')
    expect(str.string).not_to include('O')
  end

  it 'displays a mark in the correct position' do
    str = SimplifiedStringIO.new
    Display.new(str).display_board(Board.new 'X--------')
    expect(str.string.scan(/X/).length).to eq 1
  end

  it 'displays a winning board' do
    str = SimplifiedStringIO.new
    Display.new(str).display_board(Board.new 'X--OXO--X')
    expect(str.string.scan(/X/).length).to eq 3
    expect(str.string.scan(/O/).length).to eq 2
  end

  it 'prompts user for move' do
    str = SimplifiedStringIO.new('8')
    expect(Display.new(str).prompt_for_move).to eq 7
  end

  it 'displays a winner with player mark X' do
    str = SimplifiedStringIO.new
    board = Board.new('XXXOO----')
    Display.new(str).display_result(board)
    expect(str.string).to include 'X wins!'
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

  describe '#human?' do
    it 'returns true when user provides y' do
      str = SimplifiedStringIO.new("y\n")
      expect(Display.new(str).human?('X')).to eq true
    end
    
    it 'returns false when user provides n' do
      str = SimplifiedStringIO.new("n\n")
      expect(Display.new(str).human?('X')).to eq false
    end

    it 'continues to ask until the user provides a valid answer' do
      str = SimplifiedStringIO.new("a\nb\ny\n")
      expect(Display.new(str).human?('X')).to eq true
    end

    it 'displays the player mark in the output' do
      str = SimplifiedStringIO.new("y\n")
      Display.new(str).human?('X')
      expect(str.string).to include('X')
    end
  end
end
