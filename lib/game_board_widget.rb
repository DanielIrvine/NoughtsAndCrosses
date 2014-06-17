require 'qt'
require 'cell_label'

module NoughtsAndCrosses
  module GUI
    class GameBoardWidget < Qt::Widget
    
      slots :play
      attr_reader :timer, :game
    
      def initialize(parent, game)
        super(parent)
        @game = game
        @font = Qt::Font.new('Helvetica Neue', 60, 0)
        self.window_title = 'Noughts and Crosses'
        create_timer
        create_grid
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
        end
      end
    
      def set_next_human_move(index)
        @game.set_next_human_move(index)
      end

      def create_result_label
        @result = Qt::Label.new
        set_label_properties(@result)
        @grid.add_widget(@result, @game.board.size, 0, 1, @game.board.size)
      end
    
      def set_label_properties(label)
        label.setAlignment(Qt::AlignCenter)
        label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
        label.setFont(@font)
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
        @result.setText(@game.result_text)
      end
    end
  end

end
