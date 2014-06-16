require 'guier_display'
require 'qt_helpers'
require 'qt'
require 'strings'

module NoughtsAndCrosses
  module Guier

    describe GuierDisplay do

      include_context :qt
      include Strings

      let(:display) { GuierDisplay.new }

      it 'is a Qt window' do
        expect(display).to be_kind_of Qt::Widget
        expect(display.parent).to be nil
      end

      it 'displays player type options' do
        expect(display).to have_radio_button('XHuman')
        expect(display).to have_radio_button('XComputer')
        expect(display).to have_radio_button('OHuman')
        expect(display).to have_radio_button('OComputer')
      end

      it 'can set two computer players' do
        x_computer = find_widget(display, 'XComputer')
        x_computer.toggle
        o_computer = find_widget(display, 'OComputer')
        o_computer.toggle
        expect(x_computer.checked?).to be true
        expect(o_computer.checked?).to be true
      end

      it 'is set to two human players by default' do
        x_human = find_widget(display, 'XHuman')
        o_human = find_widget(display, 'OHuman') 
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
        three = find_widget(display, translate(:x3))
        four = find_widget(display, translate(:x4))
        expect(three.checked?).to be true
        expect(four.checked?).to be false
      end

      it 'can be set to 4x4' do
        three = find_widget(display, translate(:x3))
        four = find_widget(display, translate(:x4))
        four.toggle
        expect(three.checked?).to be false
        expect(four.checked?).to be true
      end

      it 'has a play button' do
        expect(display).to have_button_with_text(translate(:play))
      end

      it 'begins game when play button is clicked' do
        button = find_widget(display, 'play_button')
        emit button.clicked()
        expect(display.game).to_not be nil
        expect(display.game.x).to be_kind_of(HumanPlayer)
        expect(display.game.o).to be_kind_of(HumanPlayer)
        expect(display.game.board.size).to eq 3
      end

    end
  end
end
