require 'test_game_board_widget'
require 'test_question'
require 'test_play_timer'
require 'gui_display'

module NoughtsAndCrosses
  module GUI
    describe GUIDisplay do
      
      let(:window) { TestGameBoardWidget.new }
      let(:question) { TestQuestion.new(
        { 'Is player X human?' => true,
          'Is player O human?' => true,
          'Do you want to play a 4x4 game? Choose no for a 3x3 game.' => false }) }
      let(:timer) { TestPlayTimer.new }
      let(:display) { GUIDisplay.new(window, question, timer) }
    
      it 'displays a winning message when game is over' do
        display.begin
        [0, 1, 4, 2, 8].each do |sq|
          click(sq)
          display.play_turn
        end
        expect(has_label_with_text('X wins!')).to eq true
      end
    
    
      describe 'computer player as x' do
    
        before do
          question['Is player X human?'] = false
        end
    
        it 'plays X move when timer is fired' do
          display.begin
          timer.fire
          expect(has_label_with_text('X')).to eq true
        end
      end
    
      it 'displays a draw result' do
        display.begin
        [0, 3, 1, 4, 6, 2, 7, 8, 5].each do |sq|
          click(sq)
          display.play_turn
        end
        expect(has_label_with_text("It's a draw!")).to eq true
      end
    
      it 'displays a winning message for o' do
        display.begin
        [0, 3, 1, 4, 8, 5].each do |sq|
          click(sq)
          display.play_turn
        end
        expect(has_label_with_text('O wins!')).to eq true
      end
    
    
      it "prompts the user if player X is human" do
        expect(question).to receive(:ask).with('Is player X human?').and_return(true)
        expect(display.human?('X')).to eq true
      end
    
      it 'displays a 4x4 board' do
        question['Do you want to play a 4x4 game? Choose no for a 3x3 game.'] = true
        display.begin
        click(15)
        expect(square(15).text).to eq 'X'
      end
      
      it 'prompts the user if the game is 4x4' do
        question['Do you want to play a 4x4 game? Choose no for a 3x3 game.'] = true
        expect(display.size?).to eq 4
      end
    
      it "displays an x in the right place when played" do
        display.begin
        click(4)
        display.play_turn
        expect(square(4).text).to eq 'X'
      end
    
      it "doesn't play in an already played square" do
        display.begin
        [4, 4].each do |sq|
          click(sq)
          display.play_turn
        end
        expect(num_labels_with_text('X')).to eq 1
        expect(num_labels_with_text('O')).to eq 0
      end
    
      it 'displays multiple squares' do
        display.begin
        [1, 2, 3, 4].each do |sq|
          click(sq) 
          display.play_turn
        end
        expect(num_labels_with_text('X')).to eq 2
        expect(num_labels_with_text('O')).to eq 2
      end
    
      def click(index)
        square(index).mousePressEvent(nil)
      end
    
      def square(index)
        window.children.find{ |c| c.object_name=="square-#{index}"}
      end
      def has_label_with_text(text)
        window.children.each do |child|
          return true if child.kind_of?(Qt::Label) && child.text == text
        end
      end
    
      def num_labels_with_text(text)
        window.children.count { |child| child.kind_of?(Qt::Label) && child.text == text }
      end
    end
  end
end
