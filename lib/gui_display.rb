require 'gui_controller'

class GUIDisplay

  attr_writer :last_space_played

  CELL_SIZE = 150 

  def initialize(gui)
    @gui = gui
    @controller = GuiController.new(self)
    @gui.create_timer(@controller)
  end

  def four_by_four?
    @gui.prompt_yes_no?('Do you want to play a 4x4 game? Choose no for a 3x3 game.')
  end

  def show(board)
    @gui.display_window(board.size + 1,
                        board.size, 
                        CELL_SIZE,
                        @controller)
  end

  def human?(mark)
    @gui.prompt_yes_no?("Is player #{mark} human?")
  end

  def prompt_for_move
    @last_space_played
  end

  def has_available_move?
    @last_space_played != nil
  end

  def display_board(board)
    board.all_indexes.each do |sq|
      @gui.draw_square(board.mark_at(sq), sq) if board.played?(sq)
    end
  end

  def display_result(result_text)
    @gui.draw_result(result_text)
  end
  
  def play
    @on_play.call
  end

end
