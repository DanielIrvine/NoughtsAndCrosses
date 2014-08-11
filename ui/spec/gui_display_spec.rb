require 'spec_helper'
require 'test_question'
require 'gui_display'
require 'strings'
require 'qt'
require 'qt_helpers'

module NoughtsAndCrosses
  module GUI
    describe GUIDisplay do
     
      include_context :qt

      let(:question) { TestQuestion.new(
        { Strings.translate(:human, 'X') => true,
          Strings.translate(:human, 'O') => true,
          Strings.translate(:four_by_four) => false }) }
      let(:display) do
        display = GUIDisplay.new(question) 
        allow(display).to receive(:show)
        display
      end
    
      it 'displays a winning message when game is over' do
        display.begin
        [0, 1, 4, 2, 8].each do |sq|
          click(sq)
        end
        expect(display).to have_label_with_text(Strings.translate(:winner, 'X'))
      end
    
  
      describe 'computer player as x' do
    
        before do
          question[Strings.translate(:human, 'X')] = false
        end
    
        it 'plays X move when timer is fired' do
          display.begin
          emit display.board_widget.timer.timeout()
          expect(display).to have_label_with_text('X')
        end
      end
    
      it 'displays a draw result' do
        display.begin
        [0, 3, 1, 4, 6, 2, 7, 8, 5].each do |sq|
          click(sq)
        end
        expect(display).to have_label_with_text(Strings.translate(:draw))
      end
    
      it 'displays a winning message for o' do
        display.begin
        [0, 3, 1, 4, 8, 5].each do |sq|
          click(sq)
        end
        expect(display).to have_label_with_text(Strings.translate(:winner, 'O'))
      end
    
    
      it "prompts the user if player X is human" do
        question[Strings.translate(:human, 'X')] = true
        expect(display.human?('X')).to eq true
      end
    
      it 'displays a 4x4 board' do
        question[Strings.translate(:four_by_four)] = true
        display.begin
        click(15)
        expect(square(15).text).to eq 'X'
      end
      
      it 'prompts the user if the game is 4x4' do
        question[Strings.translate(:four_by_four)] = true
        expect(display.four_by_four?).to eq true
      end
    
      it "displays an x in the right place when played" do
        display.begin
        click(4)
        expect(square(4).text).to eq 'X'
      end
    
      it "doesn't play in an already played square" do
        display.begin
        [4, 4].each do |sq|
          click(sq)
        end
        expect(display).to have_label_with_text('X')
        expect(display).to_not have_label_with_text('O')
      end
    
      it 'displays multiple squares' do
        display.begin
        [1, 2, 3, 4].each do |sq|
          click(sq) 
        end
        expect(display).to have_labels_with_text('X', 'X')
        expect(display).to have_labels_with_text('O', 'O')
      end
    
      it 'cannot play when game is over' do
        display.begin
        [0, 1, 3, 2, 6].each do |sq|
          click(sq)
        end
        click(4)
        expect(square(4).text).to eq nil
      end

      def click(index)
        square(index).mousePressEvent(nil)
      end
    
      def square(index)
        find_widget(display, "square-#{index}")
      end

    end
  end
end
