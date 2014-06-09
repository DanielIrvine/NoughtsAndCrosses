require 'board_io'

class CLIDisplay

  def initialize(controller, io)
    @io = io
    @controller = controller
  end

  def begin
    board = @controller.begin(human?('X'),
                              human?('O'),
                              size?)
    display_board(board)
  end
  
  def human?(mark)
    @io.puts "Is player #{mark} human? Press 'y' for yes, 'n' for no."
    valid_answers = %w(y n)
    answer = @io.gets.chomp.downcase until valid_answers.include? answer
    answer == 'y'
  end

  def size?
    @io.puts "Would you like to play a 4x4 game? Press 'y' for yes, or 'n' to play a 3x3 game."
    valid_answers = %w(y n)
    answer = @io.gets.chomp.downcase until valid_answers.include? answer
    answer == 'y' ? 4 : 3
  end

  def display_board(board)
    BoardIO.new(@io, board).display
  end

  def display_result(text)
    @io.puts text
  end

  def prompt_for_move_if_necessary
    return if !@controller.next_player.kind_of?(HumanPlayer)
    @io.puts "Enter a square to play, e.g. '3':"
    square = @io.gets.to_i - 1
    @controller.set_next_human_move(square)
  end
  
  def exec
    while !@controller.game_over? 
      prompt_for_move_if_necessary
      board = @controller.play_turn!
      display_board(board)
    end
    display_result(@controller.result_text)
  end
  
end
