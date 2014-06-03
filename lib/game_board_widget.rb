require 'Qt'

class GameBoardWidget < Qt::Widget

  attr_writer :on_click

  def initialize
    super
    @font = Qt::Font.new("Helvetica", 40, Qt::Font::Bold)
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
    setWindowTitle('Noughts and Crosses')
    resize(cols * cell_size, rows * cell_size)
    #setBackgroundRole(Qt::Palette::Shadow)
    @grid = Qt::GridLayout.new
    setLayout(@grid)
    show
  end

  def draw_text(text, row, col, col_span=1)
    label = Qt::Label.new(text, self)
    label.setAlignment(Qt::AlignCenter)
    label.setFont(@font)
    @grid.addWidget(label, row, col, 1, col_span)
  end

  def mousePressEvent(event)
    @on_click.call(event.x, event.y)
  end
end
