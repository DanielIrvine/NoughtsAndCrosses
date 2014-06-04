require 'gui_display'
require 'board'

describe GUIDisplay do

  it "displays a window with space for board and result" do
    gui = double.as_null_object
    expect(gui).to receive(:display_window).with(4, 3, GUIDisplay::CELL_SIZE)
    display = GUIDisplay.new(gui)
    display.show
  end

  it "prompts the user if player X is human" do
    gui = double.as_null_object
    expect(gui).to receive(:prompt_yes_no?).with('Is player X human?').and_return(true)
    display = GUIDisplay.new(gui)
    expect(display.human?('X')).to eq true
  end

  it "displays no squares for an empty board" do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with(anything, anything)
      .exactly(0).times
    
    display = GUIDisplay.new(gui)
    display.display_board(Board.with_size(3))
  end

  it "displays an x when x is played" do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with('X', 0)
    display = GUIDisplay.new(gui)
    display.display_board(Board.with_size(3).make_move(0, 'X'))
  end

  it "displays an x in the right place when played" do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with('X', 7) 
    display = GUIDisplay.new(gui)
    display.display_board(Board.with_size(3).make_move(7, 'X'))
 end

  it 'displays multiple squares' do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with(anything, anything).exactly(3).times
    display = GUIDisplay.new(gui)
    display.display_board(Board.new 'XOX------')
  end

  it 'makes play when board is clicked' do
    gui = double.as_null_object
    display = GUIDisplay.new(gui)
    x = HumanPlayer.new(display, 'X')
    o = HumanPlayer.new(display, 'O')
    game = Game.new(x, o, display)
    display.on_play = Proc.new{ game.play_turn! }
    coord = GUIDisplay::CELL_SIZE
    display.play_at(coord, coord)
    expect(game.board.played?(4)).to eq true
  end

  it 'displays result text' do
    gui = double.as_null_object
    expect(gui).to receive(:draw_result).with("It's a draw!")
    display = GUIDisplay.new(gui)
    display.display_result("It's a draw!")
  end

end
