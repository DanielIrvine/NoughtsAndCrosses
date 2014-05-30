require 'human_player'
require 'player'

describe HumanPlayer do

  it 'uses display to get a valid move on the board' do

    display = double
    display.should_receive(:prompt_for_valid_move).with(anything).and_return(5)

    board = Board.start
    player = HumanPlayer.new(display, 'X')
    expect(player.make_move(board).mark_at(5)).to eq 'X'
  end
end
