class Display

  def initialize(io)
    @io = io
  end

  def display_board(board)
    3.times { @io.puts "         " }
  end
end
