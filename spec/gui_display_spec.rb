require 'gui_display'
require 'board'

describe GUIDisplay do

  it "displays a square window" do
    gui = double.as_null_object
    expect(gui).to receive(:display_window).with(GUIDisplay::SIZE,
                                                GUIDisplay::SIZE)
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
    expect(gui).to receive(:draw_square).with(anything, anything, anything)
      .exactly(0).times
    
    display = GUIDisplay.new(gui)
    display.display_board(Board.start)
  end

  it "displays an x when x is played" do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with('X', 0, 0)
    display = GUIDisplay.new(gui)
    display.display_board(Board.start.make_move(0, 'X'))
  end

  it "displays an x in the right place when played" do
    gui = double.as_null_object
    x = GUIDisplay::SIZE / 3
    y = GUIDisplay::SIZE / 3 * 2
    expect(gui).to receive(:draw_square).with('X', x, y) 
    display = GUIDisplay.new(gui)
    display.display_board(Board.start.make_move(7, 'X'))
 end

  it 'displays multiple squares' do
    gui = double.as_null_object
    expect(gui).to receive(:draw_square).with(anything, anything, anything).exactly(3).times
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
    coord = GUIDisplay::SIZE / 3
    display.play_at(coord, coord)
    expect(game.board.played?(4)).to eq true
  end

  it "has next move available when last space played" do
    gui = double.as_null_object
    display = GUIDisplay.new(gui)
    display.on_play = Proc.new { }
    coord = GUIDisplay::SIZE / 3
    display.play_at(coord, coord)
    expect(display.next_move_available?).to eq true
  end

  it "has no next move available when move played" do
    gui = double.as_null_object
    display = GUIDisplay.new(gui)
    display.on_play = Proc.new { }
    coord = GUIDisplay::SIZE / 3
    display.play_at(coord, coord)
    display.prompt_for_move
    expect(display.next_move_available?).to eq false
  end
end
