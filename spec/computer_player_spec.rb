require './computer_player'

describe ComputerPlayer do

  it "always wins" do
    computer = ComputerPlayer.new
    human = Player.new
    computer.is_opponent_of!(human)
    expect(win_or_draw_from_start?(computer, human)).to eq true
    expect(win_or_draw_from_start?(human, human)).to eq true
  end

  def win_or_draw_from_start?(player_x, player_o)
    win_or_draw?(Board.start, player_x.with_mark("X"), player_o.with_mark("O"), player_x)
  end

  def win_or_draw?(board, computer, human, current_player)

    if board.game_over?
      return true if board.drawn?
      return board.winner == computer
    end
    
    if(current_player.is_a?(HumanPlayer))
      return board.available_spaces.all do |sp|
        new_board = board.make_move(sp, human.mark)
        return win_or_draw?(new_board, computer, human, computer)
      end
    else
      new_board = computer.make_move(board)
      return win_or_draw?(new_board, computer, human, human)
    end
    
  end


end
