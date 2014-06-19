require 'cell_label'
require 'game_board_widget'
require 'qt'
require 'qt_helpers'
require 'strings'
require 'super_gui_display'

module NoughtsAndCrosses
  module SuperGUI

    describe SuperGUIDisplay do

      include_context :qt
      include Strings

      let(:display) { SuperGUIDisplay.new }

      it 'is a Qt window' do
        expect(display).to be_kind_of Qt::Widget
        expect(display.parent).to be nil
      end

      it 'has a title' do
        expect(display.window_title).to eq translate(:game_title)
      end
    
      it 'displays player type options' do
        expect(display).to have_radio_button(SuperGUIDisplay::XHuman)
        expect(display).to have_radio_button(SuperGUIDisplay::XComputer)
        expect(display).to have_radio_button(SuperGUIDisplay::OHuman)
        expect(display).to have_radio_button(SuperGUIDisplay::OComputer)
      end

      it 'can set two computer players' do
        x_computer = find_widget(display, SuperGUIDisplay::XComputer)
        x_computer.toggle
        o_computer = find_widget(display, SuperGUIDisplay::OComputer)
        o_computer.toggle
        expect(x_computer.checked?).to be true
        expect(o_computer.checked?).to be true
      end

      it 'is set to two human players by default' do
        x_human = find_widget(display, SuperGUIDisplay::XHuman)
        o_human = find_widget(display, SuperGUIDisplay::OHuman) 
        expect(x_human.checked?).to be true
        expect(o_human.checked?).to be true
      end

      it 'has labels for player selection' do
        x_text = translate(:player_is, 'X')
        o_text = translate(:player_is, 'O')
        expect(display).to have_label_with_text(translate(:player_is, 'X'))
        expect(display).to have_label_with_text(translate(:player_is, 'O'))
      end

      it 'has label for board size selection' do
        expect(display).to have_label_with_text(translate(:board_size))
      end

      it 'is set to 3x3 by default' do
        three = find_widget(display, SuperGUIDisplay::X3)
        four = find_widget(display, SuperGUIDisplay::X4)
        expect(three.checked?).to be true
        expect(four.checked?).to be false
      end

      it 'can be set to 4x4' do
        three = find_widget(display, SuperGUIDisplay::X3)
        four = find_widget(display, SuperGUIDisplay::X4)
        four.toggle
        expect(three.checked?).to be false
        expect(four.checked?).to be true
      end

      it 'has a play button' do
        expect(display).to have_button_with_text(translate(:play))
      end

      it 'begins game when play button is clicked' do
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        expect(display.game).to_not be nil
        expect(display.game.x).to be_kind_of(HumanPlayer)
        expect(display.game.o).to be_kind_of(HumanPlayer)
        expect(display.game.board.size).to eq 3
      end
      
      it 'can begin a computer vs computer 4x4 game' do
        find_widget(display, SuperGUIDisplay::X4).toggle
        find_widget(display, SuperGUIDisplay::XComputer).toggle
        find_widget(display, SuperGUIDisplay::OComputer).toggle
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        expect(display.game.x).to be_kind_of(ComputerPlayer)
        expect(display.game.o).to be_kind_of(ComputerPlayer)
        expect(display.game.board.size).to eq 4
      end

      it 'displays a game widget when game is started' do
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        expect(display).to have_child_of_type(NoughtsAndCrosses::GUI::GameBoardWidget)
      end

      it 'only displays one board when play is called mutliple times' do
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        emit button.clicked()
        
        expect(display).to_not have_multiple_children_of_type(NoughtsAndCrosses::GUI::GameBoardWidget)
      end

      it 'disables play button once game has started' do
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        expect(button.enabled?).to be false
      end

      it 're-enables play button after game has finished' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()

        play_until_win
        expect(play_button.enabled?).to be true
      end

      it 'displays status message for human x' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()
        
        expect(display).to have_label_with_text(translate(:human_move, 'X'))
      end

      it 'display status message for computer x' do
        find_widget(display, SuperGUIDisplay::XComputer).toggle
        button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit button.clicked()
        expect(display).to have_label_with_text(translate(:computer_move, 'X'))
      end

      it 'displays status message for human o' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()
        
        cell_button = find_widget(display, "square-0")
        cell_button.mousePressEvent(nil)
        
        expect(display).to have_label_with_text(translate(:human_move, 'O'))
      end

      it 'displays play again status when finished' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()
        play_until_win
        expect(display).to have_label_with_text(translate(:play_again))
      end
    
      it 'does not display play again status before finishing' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()
        expect(display).to_not have_label_with_text(translate(:play_again))
      end

      it 'can start a second game' do
        play_button = find_widget(display, SuperGUIDisplay::PlayButton)
        emit play_button.clicked()

        play_until_win
        emit play_button.clicked()
        expect(display).to have_label_with_text(translate(:human_move, 'X'))
        expect(display).to_not have_label_with_text('X')
        expect(display).to_not have_label_with_text('O')
      end

      def play_until_win
        [0, 3, 1, 4, 2].each do |sq|
          cell_button = find_widget(display, "square-#{sq}")
          cell_button.mousePressEvent(nil)          
        end
      end
    end
  end
end
