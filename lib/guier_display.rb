require 'qt'
require 'strings'

module NoughtsAndCrosses
  module Guier

    class GuierDisplay < Qt::Widget

      include Strings

      def initialize
        super(nil)
        self.layout = @layout = Qt::VBoxLayout.new
        create_player_selection('X')
        create_player_selection('O')
        create_board_size_selection
      end

      def begin
        show 
      end

      def create_board_size_selection
        @layout.addWidget(Qt::Label.new(translate(:board_size)))
        group = Qt::ButtonGroup.new
        button = Qt::RadioButton.new(translate(:x3), nil)
        button.object_name = translate(:x3)
        button.toggle
        group.addButton(button) 
        @layout.addWidget(button)
        button = Qt::RadioButton.new(translate(:x4), nil)
        button.object_name = translate(:x4)
        group.addButton(button) 
        @layout.addWidget(button)
      end

      def create_player_selection(mark)
        @layout.addWidget(Qt::Label.new(translate(:player_is, mark)))
        group = Qt::ButtonGroup.new
        human = radio_button(:human_button, mark, group)
        computer = radio_button(:computer_button, mark, group)

        human.toggle
      end

      def radio_button(text, mark, parent)
        button = Qt::RadioButton.new(translate(text), nil)
        button.object_name = mark + '-' + translate(text)
        parent.addButton(button)
        @layout.addWidget(button)
        button
      end

    end
  end
end
