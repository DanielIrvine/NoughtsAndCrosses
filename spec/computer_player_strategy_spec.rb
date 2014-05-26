require './computer_player_strategy'
require './human_player_strategy'

describe ComputerPlayerStrategy do

  it "always wins" do
    computer = ComputerPlayerStrategy.new
    human = HumanPlayerStrategy.new(nil)
    expect(win_or_draw_from_start?(computer, human)).to eq true
    expect(win_or_draw_from_start?(human, computer)).to eq true
  end

  def win_or_draw_from_start?(strategy_x, strategy_o)
    game = Game.new(strategy_x, strategy_o, nil)
    x = game.player_x
    o = game.player_o
    if strategy_x.is_a?(ComputerPlayerStrategy)
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
      new_board = computer.make_move(board)
      return win_or_draw?(new_board, computer, human, human)
    end
    
  end

end
