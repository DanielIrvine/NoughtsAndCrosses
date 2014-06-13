require 'Qt'
require 'cell_label'

class GameBoardWidget < Qt::Widget

  CELL_SIZE = 150

  def initialize
    super(nil)
    @font = Qt::Font.new('Helvetica Neue', 60, 0)
    setWindowTitle('Noughts and Crosses')
  end

  def display_window(rows, cols, parent)
    resize(cols * CELL_SIZE, rows * CELL_SIZE)
    create_grid(cols, parent)
    create_result_label(rows - 1, cols, CELL_SIZE)
    setLayout(@grid)
    show
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
  
  def create_grid(size, parent)
    @grid = Qt::GridLayout.new
    cells = (0...size).to_a
    cells.product(cells).each do |row, col|
      index = row * size + col
      label = CellLabel.new(index, parent)
      set_label_properties(label)
      @grid.addWidget(label, row, col)
    end
  end

  def draw_square(text, index)
    @grid.itemAt(index).widget.setText(text)
  end

  def draw_result(text)
    @result.setText(text)
  end
  
end
