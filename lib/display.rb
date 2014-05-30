require 'board_io'

class Display
  def initialize(io)
    @io = io
  end

  def human_first?
    @io.puts 'Would you like to play first? (y/n) '
    valid_answers = %w(y n)
    answer = @io.gets.chomp.downcase until valid_answers.include? answer
    answer == 'y'
  end

  def display_board(board)
    BoardIO.new(@io, board).display
  end

  def display_result(board)
    BoardIO.new(@io, board).display_result
  end

  def prompt_for_valid_move(board)
    BoardIO.new(@io, board).prompt_for_valid_move
  end
end
