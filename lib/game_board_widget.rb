require 'Qt'

class GameBoardWidget < Qt::Widget

  attr_writer :on_click, :on_play

  slots :play

  def initialize
    super
    @font = Qt::Font.new('Helvetica Neue', 60, 0)
    setWindowTitle('Noughts and Crosses')
    
    @timer = Qt::Timer.new(self)
    connect(@timer, SIGNAL(:timeout), self, SLOT(:play))

    @timer.start(1000)
  end

  def prompt_yes_no?(text)
    reply = Qt::MessageBox.question(self,
                                'Noughts and Crosses',
                                text,
                                Qt::MessageBox::Yes, Qt::MessageBox::No)
    reply == Qt::MessageBox::Yes
  end

  def display_window(rows, cols, cell_size)
    resize(cols * cell_size, rows * cell_size)
    create_grid
    create_result_label(cell_size)
    setLayout(@grid)
    show
  end

  def create_result_label(height)
    @result = create_label
    @grid.addWidget(@result, 3, 0, 1, 3)
  end

  def create_grid
    @grid = Qt::GridLayout.new
    cells = [0, 1, 2]
    cells.product(cells).each do |row, col|
      @grid.addWidget(create_label, row, col)
    end
  end

  def create_label
    label = Qt::Label.new
    label.setAlignment(Qt::AlignCenter)
    label.setFont(@font)
    label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
    label.setFrameStyle(Qt::Frame::StyledPanel | Qt::Frame::Plain);
    label
  end

  def draw_square(text, index)
    @grid.itemAt(index).widget.setText(text)
  end

  def draw_result(text)
    @result.setText(text)
  end
  
  def mousePressEvent(event)
    @on_click.call(event.x, event.y)
    @on_play.call
  end

  def play
    @on_play.call
  end

end
