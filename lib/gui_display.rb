require 'Qt'
require 'cell_label'
require 'strings'
require 'game'

module NoughtsAndCrosses
  module GUI
    class Display < Qt::Widget

      include Strings

      attr_reader :timer
      slots :play

      CELL_SIZE = 150

      def initialize(dialog)
        super(nil)
        @dialog = dialog
        @font = Qt::Font.new('Helvetica Neue', 60, 0)
        setWindowTitle('Noughts and Crosses')
        create_timer
      end
      
      def create_timer
        @timer = Qt::Timer.new
        connect(@timer, SIGNAL(:timeout), self, SLOT(:play))
      end

      def begin
        @game = Game.new(human?('X'),
                         human?('O'),
                         four_by_four?)
        display_window
      end

      def four_by_four?
        @dialog.ask(translate(:four_by_four))
      end
      
      def human?(mark)
        @dialog.ask(translate(:human, mark))
      end
      
      def display_window
        cols = @game.board.size
        rows = cols + 1
        resize(cols * CELL_SIZE, rows * CELL_SIZE)
        create_grid(cols)
        create_result_label(rows - 1, cols, CELL_SIZE)
        setLayout(@grid)
        show
        @timer.start(1000)
      end
      
      def create_result_label(row, col_span, height)
        @result = Qt::Label.new
        set_label_properties(@result)
        @grid.addWidget(@result, row, 0, 1, col_span)
      end

      def set_label_properties(label)
        label.setAlignment(Qt::AlignCenter)
        label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
        label.setFont(@font)
      end
      
      def create_grid(size)
        @grid = Qt::GridLayout.new
        cells = (0...size).to_a
        cells.product(cells).each do |row, col|
          index = row * size + col
          label = CellLabel.new(index, self)
          set_label_properties(label)
          @grid.addWidget(label, row, col)
        end
      end

      def set_next_human_move(index)
        @game.set_next_human_move(index)
      end
    
      def play
        board = @game.play_turn!
        display_board(board)
      end
      
      def draw_square(text, index)
        @grid.itemAt(index).widget.setText(text)
      end
      
      def display_board(board)
        board.all_indexes.each do |sq|
          draw_square(board.mark_at(sq), sq) if board.played?(sq)
        end
        draw_result if board.game_over?
      end

      def draw_result
        @result.setText(@game.result_text)
      end
    end
  end
  
end
