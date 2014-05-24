class Display

  HEADER_ROW = "   1  2  3"
  def initialize(io)
    @io = io
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
end
