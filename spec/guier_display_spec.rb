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

      it 'shows a window' do
        expect(display).to receive(:show)
        display.begin
      end

      it 'displays player type options' do
        expect(display).to have_radio_button('X-Human')
        expect(display).to have_radio_button('X-Computer')
        expect(display).to have_radio_button('O-Human')
        expect(display).to have_radio_button('O-Computer')
      end


      it 'can set two computer players' do
        x_computer = find_widget(display, 'X-Computer')
        x_computer.toggle
        o_computer = find_widget(display, 'O-Computer')
        o_computer.toggle
        expect(x_computer.checked?).to be true
        expect(o_computer.checked?).to be true
      end

      it 'is set to two human players by default' do
        x_human = find_widget(display, 'X-Human')
        o_human = find_widget(display, 'O-Human') 
        expect(x_human.checked?).to be true
        expect(o_human.checked?).to be true
      end

      it 'has labels for player selection' do
        expect(display).to have_label_with_text('X is...')
        expect(display).to have_label_with_text('O is...')
      end

      it 'has label for board size selection' do
        expect(display).to have_label_with_text('Board size is...')
      end

      it 'is set to 3x3 by default' do
        three = find_widget(display, translate(:x3))
        four = find_widget(display, translate(:x4))
        expect(three.checked?).to be true
        expect(four.checked?).to be false
      end
    end
  end
end
