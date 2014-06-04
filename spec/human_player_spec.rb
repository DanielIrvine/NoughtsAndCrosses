require 'human_player'
require 'player'

describe HumanPlayer do

  it 'uses display to get a move on the board' do

    display = double
    display.should_receive(:prompt_for_move).and_return(5)

    board = Board.with_size(3)
    player = HumanPlayer.new(display, 'X')
    expect(player.make_move(board).mark_at(5)).to eq 'X'
  end
end
