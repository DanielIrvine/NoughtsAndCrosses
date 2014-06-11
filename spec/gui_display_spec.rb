require 'test_game_board_widget'
require 'test_question'
require 'gui_display'

describe GUIDisplay do
  
  let(:gui) { TestGameBoardWidget.new }
  let(:question) { TestQuestion.new(
    { 'Is player X human?' => true,
      'Is player O human?' => true,
      'Do you want to play a 4x4 game? Choose no for a 3x3 game.' => false }) }
  let(:display) { GUIDisplay.new(gui, question, double.as_null_object) }

  it 'displays a winning message when game is over' do
    display.begin
    [0, 1, 4, 2, 8].each do |sq|
      click(sq)
      display.play_turn
    end
    expect(gui.result.text).to eq 'X wins!'
  end

  it 'displays a draw result' do
    display.begin
    [0, 3, 1, 4, 6, 2, 7, 8, 5].each do |sq|
      click(sq)
      display.play_turn
    end
    expect(gui.result.text).to eq "It's a draw!"
  end

  it 'displays a winning message for o' do
    display.begin
    [0, 3, 1, 4, 8, 5].each do |sq|
      click(sq)
      display.play_turn
    end
    expect(gui.result.text).to eq 'O wins!'
  end

  it "displays a window with space for board and result" do
    display.begin
    expect(gui.grid.count).to eq 10
    expect(gui.grid.itemAt(9).widget).to eq gui.result
  end

  it "prompts the user if player X is human" do
    expect(question).to receive(:ask).with('Is player X human?').and_return(true)
    expect(display.human?('X')).to eq true
  end

  it 'displays a 4x4 board' do
    question['Do you want to play a 4x4 game? Choose no for a 3x3 game.'] = true
    display.begin
    expect(gui.grid.count).to eq (4*4 + 1)
  end
  
  it 'prompts the user if the game is 4x4' do
    question['Do you want to play a 4x4 game? Choose no for a 3x3 game.'] = true
    expect(display.size?).to eq 4
  end

  it "displays an x when x is played" do
    display.begin
    click(0)
    display.play_turn
    expect(gui.grid.itemAt(0).widget.text).to eq 'X'
  end

  it "displays an x in the right place when played" do
    display.begin
    click(4)
    display.play_turn
    expect(gui.grid.itemAt(4).widget.text).to eq 'X'
  end

  it "doesn't play in an already played square" do
    display.begin
    [4, 4].each do |sq|
      click(sq)
      display.play_turn
    end
    expect(gui.grid.itemAt(4).widget.text).to eq 'X'
  end

  it 'displays multiple squares' do
    display.begin
    [1, 2, 3, 4].each do |sq|
      click(sq) 
      display.play_turn
    end
    expect(gui.grid.itemAt(1).widget.text).to eq 'X'
    expect(gui.grid.itemAt(2).widget.text).to eq 'O'
    expect(gui.grid.itemAt(3).widget.text).to eq 'X'
    expect(gui.grid.itemAt(4).widget.text).to eq 'O'
  end

  def click(index)
    gui.grid.itemAt(index).widget.mousePressEvent(nil) 
  end
end
