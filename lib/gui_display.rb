require 'Qt'
require 'cell_label'
require 'strings'
require 'game'
require 'game_board_widget'

module NoughtsAndCrosses
  module GUI
    class Display < Qt::Widget

      attr_reader :board_widget

      include Strings

      def initialize(dialog)
        super(nil)
        @dialog = dialog
      end
      
      def begin
        @game = Game.new(human?('X'),
                         human?('O'),
                         four_by_four?)
        @board_widget = GameBoardWidget.new(self, @game)

      end

      def four_by_four?
        @dialog.ask(translate(:four_by_four))
      end
      
      def human?(mark)
        @dialog.ask(translate(:human, mark))
      end
      
      def reset
      end
    end
  end
end
