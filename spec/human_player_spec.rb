require './human_player'

describe HumanPlayer do

  it "uses display to get a valid move on the board" do

    display = double()
    display.should_receive(:get_valid_move).with(anything()).and_return(5)

    board = Board.start
    player = HumanPlayer.new(display).with_mark("X")
    expect(player.make_move(board).mark_at(5)).to eq "X"
  end
end
