require './human_player_strategy'
require './player'

describe HumanPlayerStrategy do

  it "uses display to get a valid move on the board" do

    display = double()
    display.should_receive(:get_valid_move).with(anything()).and_return(5)

    board = Board.start
    strategy = HumanPlayerStrategy.new(display)
    player = Player.new("X", strategy, nil)
    expect(strategy.make_move(board, player, nil).mark_at(5)).to eq "X"
  end
end
