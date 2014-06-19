require 'cell_label'
require 'game_board_widget'
require 'game'
require 'qt'
require 'strings'

module NoughtsAndCrosses
  module SuperGui

    class SuperGuiDisplay < Qt::Widget

      BOARD_LENGTH = 500
      TEXT_FONT = Qt::Font.new(GUI::GameBoardWidget::FONT_FAMILY, 12, 0)

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
        self.window_title = translate(:game_title) 
        @layout.spacing = 8
        @layout.add_layout(@top_box_layout = Qt::HBoxLayout.new)
        @top_box_layout.alignment = Qt::AlignTop
        create_player_selection('X', XHuman, XComputer)
        create_player_selection('O', OHuman, OComputer)
        create_board_size_selection
        create_play_button
        create_play_again_label
        resize(BOARD_LENGTH, BOARD_LENGTH * 1.5) 
        show
      end
      
      def begin
        @play_again.hide
        @game_widget.dispose if @game_widget

        toggle_selection_widgets(false)

        @game = Game.new(@buttons[XHuman].checked?,
                         @buttons[OHuman].checked?,
                         @buttons[X4].checked?)

        @game_widget = GUI::GameBoardWidget.new(self, @game)
        @layout.add_widget(@game_widget)
      end

      def create_play_again_label
        @frame = Qt::StackedWidget.new(self)
        @play_again = Qt::Label.new(translate(:play_again))
        @play_again.alignment = Qt::AlignCenter
        @play_again.font = GUI::GameBoardWidget::SMALL_FONT
        @frame.minimum_height = 50
        @frame.maximum_height = 50
        @frame.add_widget(@play_again)
        @layout.add_widget(@frame)
        @play_again.hide
      end

      def reset
        toggle_selection_widgets(true)
        @play_again.show
      end

      def create_play_button
        @play_button = Qt::PushButton.new(translate(:play), self)
        @play_button.object_name = PlayButton
        @play_button.font = TEXT_FONT
        connect(@play_button, SIGNAL(:clicked), self, SLOT(:begin))
        @top_box_layout.addWidget(@play_button)
      end

      def create_board_size_selection
        create_choice_buttons(translate(:board_size),
                           [ { :id => X3,
                               :text => :x3,
                               :toggle => true },
                             { :id => X4,
                               :text => :x4} ])
      end

      def create_player_selection(mark, human, computer)
        create_choice_buttons( translate(:player_is, mark),
                            [ { :id => human,
                                :text => :human_button,
                                 :toggle => true },
                               { :id => computer,
                                 :text => :computer_button } ])
      end
      
      def toggle_selection_widgets(on)
        self.find_children(Qt::Widget).each do |w|
          w.enabled = on 
        end
      end

      def create_choice_buttons(title, buttons)
        layout = Qt::VBoxLayout.new
        title = Qt::Label.new(title)
        title.font = TEXT_FONT
        layout.add_widget(title)
        group = Qt::ButtonGroup.new
        buttons.each do |b|
          layout.add_widget(create_choice(b, group))
        end
        @top_box_layout.add_layout(layout)
      end

      def create_choice(choice, group)
        label_text = translate(choice[:text])
        button = Qt::RadioButton.new(label_text, nil)
        button.font = TEXT_FONT
        button.object_name = choice[:id]
        button.toggle if choice[:toggle]
        group.add_button(button)
        @buttons[choice[:id]] = button
        button
      end
    end
  end
end
