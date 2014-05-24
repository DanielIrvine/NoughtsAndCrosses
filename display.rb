class Display

  def initialize(io)
    @io = io
  end

  def display_board(board)
    (0..2).each do |row|

      line = ""
      (0..2).each do |column|
        pos = row*3 + column
        line << " "
        line << (board.played?(pos) ? board.mark_at(pos) : " ")
        line << " "
      end
      @io.puts line
    end
  end
end
