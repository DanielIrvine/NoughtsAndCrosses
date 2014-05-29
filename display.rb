class Display

  HEADER_ROW = "┌━━━┬━━━┬━━━┐"
  MIDDLE_ROW = "|━━━┼━━━┼━━━|"
  FOOTER_ROW = "└━━━┴━━━┴━━━┘"
  
  MAIN_COLOR = "\033[1;39m"
  GREY_COLOR = "\033[1;30m" 
  
  def initialize(io)
    @io = io
  end

  def human_first?
    @io.puts MAIN_COLOR + "Would you like to play first? (y/n) "
    while (true)
      answer = @io.gets.chomp
      return true if answer.downcase == "y"
      return false if answer.downcase == "n"
    end
  end

  def display_result(board)
    @io.puts board.won? ? board.winner + " wins!" : "It's a draw!" 
  end

  def display_board(board)
    @io.puts [HEADER_ROW,
              middle_rows(board),
              FOOTER_ROW].flatten.join("\n")
  end

  def middle_rows(board)
    test = (0..4).map do |row|
      row % 2 == 1 ? MIDDLE_ROW : display_row(row/2, board)
    end
  end
  
  def display_row(row, board)
    line = '|' 
    (0..2).each do |column|
      pos = row*3 + column
      line << ' ' 
      line << character_for_square(pos, board) 
      line << ' |'
    end
    line
  end

  def character_for_square(pos, board)
    board.played?(pos) ? board.mark_at(pos) : grey_text((pos+1).to_s)
  end

  def grey_text(text)
    GREY_COLOR + text + MAIN_COLOR 
  end

  def get_valid_move(board)
    @io.puts "Enter a square to play, e.g. '3':"

    @io.rewind

    spaces = board.available_spaces
    pos = @io.gets.to_i - 1 until spaces.include?(pos)
    pos
  end

end
