require 'board_io'

class CLIDisplay
  def initialize(io)
    @io = io
  end

  def human?(mark)
    @io.puts "Is player #{mark} human? Press 'y' for yes, 'n' for no."
    valid_answers = %w(y n)
    answer = @io.gets.chomp.downcase until valid_answers.include? answer
    answer == 'y'
  end

  def show
    BoardIO.new(@io, Board.start).display
  end
  def display_board(board)
    BoardIO.new(@io, board).display
  end

  def display_result(text)
    @io.puts text
  end

  def prompt_for_move
    @io.puts "Enter a square to play, e.g. '3':"
    @io.gets.to_i - 1
  end

end
