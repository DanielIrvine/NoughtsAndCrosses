require 'play_timer'

class GUIDisplay

  CELL_SIZE = 150 

  def initialize(controller, gui)
    @gui = gui
    @controller = controller 
  end

  def begin
    board = @controller.begin(human?('X'),
                              human?('O'),
                              size?)
    @gui.display_window(board.size + 1,
                        board.size,
                        CELL_SIZE,
                        self)
  end


  def size?
    four_by_four = @gui.prompt_yes_no?('Do you want to play a 4x4 game? Choose no for a 3x3 game.')
    four_by_four ? 4 : 3
  end

  def human?(mark)
    @gui.prompt_yes_no?("Is player #{mark} human?")
  end

  def display_board(board)
    board.all_indexes.each do |sq|
      @gui.draw_square(board.mark_at(sq), sq) if board.played?(sq)
    end
  end

  def display_result(result_text)
    @gui.draw_result(result_text)
  end
  
  def play_turn
    board = @controller.play_turn!
    display_board(board)
    display_result(@controller.result_text) if board.game_over?
  end

  def set_next_human_move(square)
    @controller.set_next_human_move(square)
  end
end
