require 'cell_label'
require 'game_board_widget'
require 'game'
require 'qt'
require 'strings'

module NoughtsAndCrosses
  module SuperGui

    class SuperGuiDisplay < Qt::Widget

      include Strings

      slots :begin
      attr_reader :game
      
      X3 = 'x3'
      X4 = 'x4'
      XHuman = 'XHuman'
      OHuman = 'OHuman'
      XComputer = 'XComputer'
      OComputer = 'OComputer'
      PlayButton = 'PlayButton'

      def initialize
        super(nil)
        @buttons = {}
        self.layout = @layout = Qt::VBoxLayout.new
        self.window_title = 'Noughts and Crosses'
        @layout.add_layout(@top_box_layout = Qt::HBoxLayout.new)
        @top_box_layout.alignment = Qt::AlignTop
        create_player_selection('X', XHuman, XComputer)
        create_player_selection('O', OHuman, OComputer)
        create_board_size_selection
        create_play_button
        resize(GUI::CellLabel::CELL_SIZE * 4, GUI::CellLabel::CELL_SIZE * 5)
        show
      end

      def begin
        @game = Game.new(@buttons[XHuman].checked?,
                         @buttons[OHuman].checked?,
                         @buttons[X4].checked?)

        @layout.add_widget(GUI::GameBoardWidget.new(self, @game))
      end

      def create_play_button
        @play_button = Qt::PushButton.new(translate(:play), self)
        @play_button.object_name = PlayButton
        connect(@play_button, SIGNAL(:clicked), self, SLOT(:begin))
        @top_box_layout.addWidget(@play_button)
      end

      def create_board_size_selection
        create_buttons(translate(:board_size),
                       [ { :id => X3,
                           :text => :x3,
                           :toggle => true },
                         { :id => X4,
                           :text => :x4} ])
      end

      def create_player_selection(mark, human, computer)
        create_buttons( translate(:player_is, mark),
                       [ { :id => human,
                           :text => :human_button,
                            :toggle => true },
                          { :id => computer,
                            :text => :computer_button } ])
      end

      def create_buttons(title, buttons)
        layout = Qt::VBoxLayout.new
        layout.add_widget(Qt::Label.new(title))
        group = Qt::ButtonGroup.new
        buttons.each do |b|
          label = translate(b[:text])
          button = Qt::RadioButton.new(label, nil)
          button.object_name = b[:id] 
          button.toggle if b[:toggle]
          group.add_button(button)        
          layout.add_widget(button)
          @buttons[b[:id]] = button
        end
        @top_box_layout.add_layout(layout)
      end

    end
  end
end
