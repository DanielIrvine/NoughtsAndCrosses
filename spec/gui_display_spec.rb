require 'gui_display'
require 'board'
require 'game'
require 'controller'
require 'first_available_space_player'
require 'game_board_widget'

describe GUIDisplay do
  
  let(:x) { FirstAvailableSpacePlayer.new('X') }
  let(:o) { FirstAvailableSpacePlayer.new('O') }
  let(:io) { double.as_null_object }

  it 'displays a winning message when game is over' do
    expect(io).to receive(:draw_result).with('X wins!')
    game = Game.new(x, o, Board.new('XX-OO----'))
    controller = Controller.new(game)
    gui = GUIDisplay.new(controller, io).play_turn
  end

  it 'displays a draw result' do
    expect(io).to receive(:draw_result).with("It's a draw!")
    game = Game.new(x, o, Board.new('XXOOOXXO-'))
    controller = Controller.new(game)
    gui = GUIDisplay.new(controller, io).play_turn
  end

  it 'displays a winning message for o' do
    expect(io).to receive(:draw_result).with('O wins!')
    game = Game.new(x, o, Board.new('XXOXO-O--'))
    controller = Controller.new(game)
    GUIDisplay.new(controller, io).play_turn
  end

  it 'displays the board after each move' do
    expect(io).to receive(:draw_square).with(anything, anything).exactly(9).times
    game = Game.new(x, o, Board.new('XXOOOXXOX'))
    controller = Controller.new(game)
    GUIDisplay.new(controller, io).play_turn
  end

  it "displays a window with space for board and result" do
    io = double
    expect(io).to receive(:display_window).with(4, 3, GUIDisplay::CELL_SIZE, anything)
    expect(io).to receive(:prompt_yes_no?).with(anything).and_return(false).exactly(3).times
    GUIDisplay.new(Controller.new, io).begin
  end

  it "prompts the user if player X is human" do
    expect(io).to receive(:prompt_yes_no?).with('Is player X human?').and_return(true)
    display = GUIDisplay.new(Controller.new, io)
    expect(display.human?('X')).to eq true
  end

  it 'displays a window for a 4x4 game' do
    expect(io).to receive(:prompt_yes_no?).with(anything).and_return(true)
    expect(io).to receive(:display_window).with(5, 4, GUIDisplay::CELL_SIZE, anything)
    display = GUIDisplay.new(Controller.new, io)
    display.begin
  end
  
  it 'prompts the user if the game is 4x4' do
    expect(io).to receive(:prompt_yes_no?).with('Do you want to play a 4x4 game? Choose no for a 3x3 game.').and_return(true)
    display = GUIDisplay.new(Controller.new, io)
    expect(display.size?).to eq 4
  end

  it "displays an x when x is played" do
    expect(io).to receive(:draw_square).with('X', 0)
    game = Game.new(x, o, Board.with_size(3))
    controller = Controller.new(game)
    GUIDisplay.new(controller, io).play_turn
  end

  it "displays an x in the right place when played" do
    expect(io).to receive(:draw_square).with('X', 4)
    game = Game.new(x, o, Board.new('OOOO-----'))
    controller = Controller.new(game)
    GUIDisplay.new(controller, io).play_turn
  end

  it 'displays multiple squares' do
    expect(io).to receive(:draw_square).with(anything, anything).exactly(4).times
    game = Game.new(x, o, Board.new('XOX------'))
    controller = Controller.new(game)
    GUIDisplay.new(controller, io).play_turn
  end

  # TODO: this needs to be run against non-Qt code somehow
  xit 'makes play when board is clicked' do
    app = Qt::Application.new(ARGV)
    io = GameBoardWidget.new
    display = GUIDisplay.new(Controller.new, io)
    io.grid[4].mousePressEvent(nil)
    expect(game.board.played?(4)).to eq true
  end

end
