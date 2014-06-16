require 'qt'
require 'strings'

module NoughtsAndCrosses
  module Guier

    class GuierDisplay < Qt::Widget

      include Strings

      slots :begin
      attr_reader :game
      
      def initialize
        super(nil)
        self.layout = @layout = Qt::VBoxLayout.new
        @layout.addLayout(@top_box_layout = Qt::HBoxLayout.new)
        create_player_selection('X')
        create_player_selection('O')
        create_board_size_selection
        create_play_button
      end

      def begin
        @game = Game.new(true,
                         true,
                         false)
      end

      def create_play_button
        @play_button = Qt::PushButton.new(translate(:play), self)
        @play_button.object_name = 'play_button'
        connect(@play_button, SIGNAL(:clicked), self, SLOT(:begin))
        @top_box_layout.addWidget(@play_button)
      end

      def create_board_size_selection
        create_buttons(translate(:board_size),
                       [ { :id => :x3,
                           :toggle => true },
                         { :id => :x4 } ])
      end

      def create_player_selection(mark)
        create_buttons( translate(:player_is, mark),
                       [ { :id => :human_button,
                            :prefix => mark,
                            :toggle => true },
                          { :id => :computer_button,
                            :prefix => mark } ])
      end

      def create_buttons(title, buttons)
        layout = Qt::VBoxLayout.new
        layout.addWidget(Qt::Label.new(title))
        group = Qt::ButtonGroup.new
        buttons.each do |b|
          label = translate(b[:id])
          prefix = b[:prefix] || '' 
          button = Qt::RadioButton.new(label, nil)
          button.object_name = prefix + label 
          button.toggle if b[:toggle]
          group.addButton(button)        
          layout.addWidget(button)
        end
        @top_box_layout.addLayout(layout)
      end
    end
  end
end
