require 'gui_display'
require 'test_game_board_widget'

describe GUIDisplay do
  
  let(:gui) { double.as_null_object }
  let (:display) { display = GUIDisplay.new(gui) }

  it 'displays a winning message when game is over' do
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true, true, false)
    expect(gui).to receive(:draw_result).with('X wins!')
    display.begin
    [0, 1, 4, 2, 8].each do |sq|
      display.set_next_human_move(sq)
      display.play_turn
    end
  end

  it 'displays a draw result' do
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true, true, false)
    expect(gui).to receive(:draw_result).with("It's a draw!")
    display.begin
    [0, 3, 1, 4, 6, 2, 7, 8, 5].each do |sq|
      display.set_next_human_move(sq)
      display.play_turn
    end
  end

  it 'displays a winning message for o' do
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true, true, false)
    expect(gui).to receive(:draw_result).with('O wins!')
    display.begin
    [0, 3, 1, 4, 8, 5].each do |sq|
      display.set_next_human_move(sq)
      display.play_turn
    end
  end

  it "displays a window with space for board and result" do
    expect(gui).to receive(:display_window).with(4, 3, anything)
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(false).exactly(3).times
    display.begin
  end

  it "prompts the user if player X is human" do
    expect(gui).to receive(:prompt_yes_no?).with('Is player X human?').and_return(true)
    expect(display.human?('X')).to eq true
  end

  it 'displays a 4x4 board' do
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true)
    expect(gui).to receive(:display_window).with(5, 4, GUIDisplay::CELL_SIZE, anything)
    display.begin
  end
  
  it 'prompts the user if the game is 4x4' do
    expect(gui).to receive(:prompt_yes_no?).with('Do you want to play a 4x4 game? Choose no for a 3x3 game.').and_return(true)
    expect(display.size?).to eq 4
  end

  it "displays an x when x is played" do
    expect(gui).to receive(:draw_square).with('X', 0)
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true)
    display.begin
    display.set_next_human_move(0)
    display.play_turn
  end

  it "displays an x in the right place when played" do
    expect(gui).to receive(:draw_square).with('X', 4)
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true)
    display.begin
    display.set_next_human_move(4)
    display.play_turn
  end

  it "doesn't play in an already played square" do
    expect(gui).to receive(:draw_square).with('X', 4).exactly(2).times
    expect(gui).to receive(:prompt_yes_no?).with(anything).and_return(true)
    display.begin
    [4, 4].each do |sq|
      display.set_next_human_move(sq)
      display.play_turn
    end
  end

  it 'displays multiple squares' do
    expect(gui).to receive(:draw_square).with(anything, anything).exactly(1+ 2 + 3 + 4).times
    display.begin
    [1, 2, 3, 4].each do |sq|
      display.set_next_human_move(sq)
      display.play_turn
    end
  end

  it 'makes play when board is clicked' do
    gui = TestGameBoardWidget.new
    display = GUIDisplay.new(gui)
    display.begin
    gui.grid.itemAt(4).widget.mousePressEvent(nil)
    expect(gui.grid.itemAt(4).widget.text=='X').to eq true
  end

end
