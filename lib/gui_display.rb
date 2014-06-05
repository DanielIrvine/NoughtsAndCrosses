class GUIDisplay

  attr_writer :on_play

  CELL_SIZE = 150 

  def initialize(gui)
    @gui = gui
    @gui.on_click = Proc.new{ |x,y| play_at(x, y) }
    @gui.on_play = Proc.new { @on_play.call if !@on_play.nil? }
  end

  def four_by_four?
    @gui.prompt_yes_no?('Do you want to play a 4x4 game? Choose no for a 3x3 game.')
  end

  def show(board)
    @gui.display_window(board.size + 1, board.size, CELL_SIZE)
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
  
  def play_at(x, y)
    space = convert_to_space(x, y)    
    @last_space_played = space
    @on_play.call
  end

  def convert_to_space(x, y)
    col = (x / CELL_SIZE).to_i
    row = (y / CELL_SIZE).to_i
    row * 3 + col
  end
  
end
