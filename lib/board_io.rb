class BoardIO
  MAIN_COLOR = "\033[1;39m"
  GREY_COLOR = "\033[1;30m"

  HEADER_ROW = '┌━━━┬━━━┬━━━┐'
  MIDDLE_ROW = '|━━━┼━━━┼━━━|'
  FOOTER_ROW = '└━━━┴━━━┴━━━┘'

  def initialize(io, board)
    @io = io
    @board = board
  end

  def display_result
    if @board.won?
      output = @board.winner + ' wins!'
    else
      output = "It's a draw!"
    end
    @io.puts output
  end

  def display
    @io.puts [MAIN_COLOR,
              HEADER_ROW,
              middle_rows,
              FOOTER_ROW].flatten.join("\n")
  end

  def middle_rows
    (0..4).map do |row|
      row.odd? ? MIDDLE_ROW : display_row(row / 2)
    end
  end

  def display_row(row)
    line = '|'
    (0..2).each do |column|
      pos = row * 3 + column
      line << ' ' + character_for_square(pos) + ' |'
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
