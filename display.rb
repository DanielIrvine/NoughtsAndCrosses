class Display

  HEADER_ROW = "   1  2  3"
  def initialize(io)
    @io = io
  end

  def human_first?
    @io.puts "Would you like to play first? (y/n) "
    while (true)
      answer = @io.gets
      return true if answer.downcase == "y"
      return false if answer.downcase == "n"
    end
  end

  def display_winner(player)
    @io.puts player.mark + " wins!"; 
  end
  
  def display_board(board)
    @io.puts HEADER_ROW
    (0..2).each do |row|

      line = (row + 1).to_s
      (0..2).each do |column|
        pos = row*3 + column
        line << "  "
        line << (board.played?(pos) ? board.mark_at(pos) : " ")
      end
      @io.puts line
    end
  end

  def get_valid_move(board)

    @io.puts "Enter a row and column to play, e.g. '3 2':"
    while(true)

      row, column = @io.gets.split(' ').map { |p| p.to_i }
      if(valid?(row) && valid?(column))
        position = convert_move(row, column)
        if(board.available_spaces.include?(position))
          return position
        end
      end
    end
  end

  def convert_move(row, column)
    return (row.to_i-1)*3 + column.to_i - 1
  end

  def valid?(coord)
    (1..3).include?(coord)
  end
end
