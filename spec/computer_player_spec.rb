require 'spec_helper'
require 'computer_player'

describe ComputerPlayer do

  it 'always wins' do

    computer = ComputerPlayer.new('X', 'O')
    human = HumanPlayer.new(nil, 'O')
    expect(win_or_draw_from_start?(computer, human)).to eq true
    computer = ComputerPlayer.new('O', 'X')
    human = HumanPlayer.new(nil, 'X')
    expect(win_or_draw_from_start?(human, computer)).to eq true
  end

  def win_or_draw_from_start?(x, o)
    if x.is_a?(ComputerPlayer)
      win_or_draw?(Board.start, x, o, x)
    else
      win_or_draw?(Board.start, o, x, x)
    end
  end

  def win_or_draw?(board, computer, human, current_player)
    if board.game_over?
      return true if board.drawn?
      return board.winner == computer.mark
    end

    if current_player == human
      make_all_human_moves(board, computer, human)
    else
      make_computer_move(board, computer, human)
    end
  end

  def make_all_human_moves(board, computer, human)
    board.available_spaces.all? do |sp|
      new_board = board.make_move(sp, human.mark)
      win_or_draw?(new_board, computer, human, computer)
    end
  end

  def make_computer_move(board, computer, human)
    new_board = computer.make_move(board)
    win_or_draw?(new_board, computer, human, human)
  end
end
