require 'qt'
require 'cell_label'

module NoughtsAndCrosses
  module GUI
    class GameBoardWidget < Qt::Widget
    
      FONT_FAMILY = 'Helvetica Neue'

      slots :play
      attr_reader :timer, :game
    
      def initialize(parent, game)
        super(parent)
        @game = game
        @font = Qt::Font.new(FONT_FAMILY, 60, 0)
        @small_font = Qt::Font.new(FONT_FAMILY, 24, 0)
        self.window_title = 'Noughts and Crosses'
        create_timer
        create_grid
        create_status_label
        create_result_label
      end
    
      def create_timer
        @timer = Qt::Timer.new
        connect(@timer, SIGNAL(:timeout), self, SLOT(:play))
      end
    
      def play
        board = @game.play_turn!
        display_board(board)
        if @game.game_over?
          draw_result
          self.parent.reset
        else
          set_next_status
        end
      end
    
      def set_next_human_move(index)
        @game.set_next_human_move(index)
      end

      def create_status_label
        @status = Qt::Label.new
        set_label_properties(@status, @small_font)
        @grid.add_widget(@status, @game.board.size, 0, 1, @game.board.size)
        set_next_status
      end

      def set_next_status
        mark = @game.next_player.mark
        text = "#{mark}'s move: "
        text += if (@game.next_player.kind_of?(HumanPlayer))
                  "click a square"
                else
                  "thinking..."
                end
        @status.text = text
      end

      def create_result_label
        @result = Qt::Label.new
        set_label_properties(@result)
        @grid.add_widget(@result, @game.board.size, 0, 1, @game.board.size)
      end
    
      def set_label_properties(label, font = @font)
        label.setAlignment(Qt::AlignCenter)
        label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
        label.setFont(font)
      end
    
      def create_grid
        size = @game.board.size
        @grid = Qt::GridLayout.new(self)
        self.layout = @grid
        cells = (0...size).to_a
        cells.product(cells).each do |row, col|
          index = row * size + col
          label = CellLabel.new(index, self)
          set_label_properties(label)
          @grid.add_widget(label, row, col)
        end
      end
    
      def draw_square(text, index)
        @grid.itemAt(index).widget.setText(text)
      end
      
      def display_board(board)
        board.all_indexes.each do |sq|
          draw_square(board.mark_at(sq), sq) if board.played?(sq)
        end
      end
    
      def draw_result
        @status.hide
        @result.setText(@game.result_text)
      end
    end
  end

end
