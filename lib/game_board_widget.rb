require 'Qt'

class GameBoardWidget < Qt::Widget

  attr_writer :on_click

  def initialize
    super
    @font = Qt::Font.new('Helvetica Neue', 60, 0)
    setWindowTitle('Noughts and Crosses')
  end

  def prompt_yes_no?(text)
    reply = Qt::MessageBox.question(self,
                                'Noughts and Crosses',
                                text,
                                Qt::MessageBox::Yes, Qt::MessageBox::No)
    reply == Qt::MessageBox::Yes
  end

  def exec
    @app.exec
  end

  def display_window(rows, cols, cell_size)
    resize(cols * cell_size, rows * cell_size)
    create_grid
    create_result_label
    create_vertical_layout
    show
  end

  def create_result_label
    @result = create_label 
    @result.setSizePolicy(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred) 
  end

  def create_vertical_layout
    vBox = Qt::VBoxLayout.new
    vBox.addLayout(@grid)
    vBox.addWidget(@result)
    setLayout(vBox)
  end
  
  def create_grid
    @grid = Qt::GridLayout.new
    cells = [0, 1, 2]
    cells.product(cells).each do |row, col|
      @grid.addWidget(create_label, row, col)
    end
  end

  def create_label
    label = Qt::Label.new(self)
    label.setAlignment(Qt::AlignCenter)
    label.setFont(@font)
    label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
    label
  end

  def draw_square(text, index)
    label = @grid.itemAt(index)
    label.widget.setText(text)
  end

  def draw_result(text)
    @result.setText(text)
  end
  
  def mousePressEvent(event)
    @on_click.call(event.x, event.y)
  end
end
