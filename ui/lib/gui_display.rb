require 'Qt'
require 'cell_label'
require 'strings'
require 'game'
require 'game_board_widget'

module NoughtsAndCrosses
  module GUI
    class GUIDisplay < Qt::Widget

      BOARD_LENGTH = 500

      include Strings

      attr_reader :board_widget

      def initialize(dialog)
        super(nil)
        @dialog = dialog
        @layout = Qt::VBoxLayout.new(self)
        resize(BOARD_LENGTH, BOARD_LENGTH * 1.5)
      end
      
      def begin
        @game = Game.new(human?('X'),
                         human?('O'),
                         four_by_four?)
        @board_widget = GameBoardWidget.new(self, @game)
        @board_widget.setSizePolicy(Qt::SizePolicy::Expanding,
                                    Qt::SizePolicy::Expanding)
        @layout.add_widget(@board_widget)
        show
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
