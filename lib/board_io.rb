class BoardIO
  MAIN_COLOR = "\033[1;39m"
  GREY_COLOR = "\033[1;30m"

  TOP_JOINS = '┌┬┐'
  MIDDLE_JOINS = '|┼|'
  BOTTOM_JOINS = '└┴┘'

  HORIZONTAL = '━━━'
  VERTICAL = '|'

  def initialize(io, board)
    @io = io
    @board = board
  end

  def display
    @io.puts [MAIN_COLOR,
              join_row(TOP_JOINS),
              middle_rows,
              join_row(BOTTOM_JOINS)].flatten.join("\n")
  end

  def join_row(joins)
    joins[0] + horizontal_segment(joins[1]) + HORIZONTAL + joins[2]
  end

  def horizontal_segment(join_character)
    line = ''
    (@board.size - 1).times { line << HORIZONTAL + join_character }
    line
  end
  
  def middle_rows
    num_rows = (@board.size*2) - 2
    (0..num_rows).map do |row|
      row.odd? ? join_row(MIDDLE_JOINS) : display_row(row / 2)
    end
  end

  def display_row(row)
    line = String.new(VERTICAL)
    num_lines = @board.size-1
    (0..num_lines).each do |column|
      pos = row * @board.size + column
      line << ' ' + character_for_square(pos) + ' ' + VERTICAL
    end
    line
  end

  def character_for_square(pos)
    if @board.played?(pos)
      @board.mark_at(pos)
    else
      grey_text((pos + 1).to_s)
    end
  end

  def grey_text(text)
    GREY_COLOR + text + MAIN_COLOR
  end

end
