require 'spec_helper'
require 'simplified_string_io'
require 'cli_display'

describe CLIDisplay do

  it 'plays until game over' do
    seq = %w(y y n 1 2 5 3 9) * "\n"
    io = SimplifiedStringIO.new(seq)
    display = CLIDisplay.new(io)
    display.begin
    display.exec
    expect(io.string).to end_with("X wins!\n")
  end

  it 'displays an empty square for the empty board' do
    str = SimplifiedStringIO.new
    CLIDisplay.new(str).display_board(Board.with_size(3))
    expect(str.string).not_to include('X')
    expect(str.string).not_to include('O')
  end

  it 'displays a mark in the correct position' do
    str = SimplifiedStringIO.new
    CLIDisplay.new(str).display_board(Board.new 'X--------')
    expect(str.string.scan(/X/).length).to eq 1
  end

  it 'displays a 4x4 board' do
    str = SimplifiedStringIO.new
    CLIDisplay.new(str).display_board(Board.new 'XXXOOOOXXXOOOOXX')
    expect(str.string.scan(/X/).length).to eq 8
    expect(str.string.scan(/O/).length).to eq 8
  end
  
  it 'displays a winning board' do
    str = SimplifiedStringIO.new
    CLIDisplay.new(str).display_board(Board.new 'X--OXO--X')
    expect(str.string.scan(/X/).length).to eq 3
    expect(str.string.scan(/O/).length).to eq 2
  end

  it 'displays result text' do
    io = double
    expect(io).to receive(:puts).with('O wins!')
    CLIDisplay.new(io).display_result('O wins!')
  end

  describe '#human?' do
    it 'returns true when user provides y' do
      str = SimplifiedStringIO.new("y\n")
      expect(CLIDisplay.new(str).human?('X')).to eq true
    end
    
    it 'returns false when user provides n' do
      str = SimplifiedStringIO.new("n\n")
      expect(CLIDisplay.new(str).human?('X')).to eq false
    end

    it 'continues to ask until the user provides a valid answer' do
      str = SimplifiedStringIO.new("a\nb\ny\n")
      expect(CLIDisplay.new(str).human?('X')).to eq true
    end

    it 'displays the player mark in the output' do
      str = SimplifiedStringIO.new("y\n")
      CLIDisplay.new(str).human?('X')
      expect(str.string).to include('X')
    end
  end
end
