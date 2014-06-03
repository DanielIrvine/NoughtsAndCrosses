require 'Qt'

class GameBoardWidget < Qt::Widget

  attr_writer :on_click

  def initialize
    super(nil)
    @font = Qt::Font("Helvetica", 40, Qt::Font::Bold)
  end

  def prompt_yes_no?(text)
    reply = Qt::MessageBox::question(@parent_widget,
                                'Noughts and Crosses',
                                text,
                                Qt::MessageBox::Yes | Qt::MessageBox::No)
    reply == Qt::MessageBox::Yes
  end

  def exec
    @app.exec
  end

  def display_window(rows, cols, cell_size)
    setCaption('Noughts and Crosses')
    resize(rows * cell_size, cols * cell_size)
    @grid = Qt::GridLayout.new(self, rows, cols)
    @grid.addStretch(1)
    show
  end

  def draw_text(text, row, col, col_span)
    label = Qt::Label.new(text, nil)
    label.setAlignment(Qt::AlignCenter)
    label.setFont(@font)
    @grid.addWidget(label, row, col, 1, col_span)
  end

  def mousePressEvent(event)
    on_click.call(event.x, event.y)
  end
end
