require './computer_player'

describe ComputerPlayer do

  it "always wins" do
    computer = ComputerPlayer.new('X')
    human = HumanPlayer.new(display, 'O')
    expect(win_or_draw_from_start?(computer, human)).to eq true
    computer = ComputerPlayer.new('O')
    human = HumanPlayer.new(display, 'X')
    expect(win_or_draw_from_start?(human, computer)).to eq true
  end

  def win_or_draw_from_start?(x, o)
    game = Game.new(x, o, nil)
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
    
    if(current_player == human)
      return board.available_spaces.all? do |sp|
        new_board = board.make_move(sp, human.mark)
        return win_or_draw?(new_board, computer, human, computer)
      end
    else
      new_board = computer.make_move(board, human)
      return win_or_draw?(new_board, computer, human, human)
    end
    
  end

end
