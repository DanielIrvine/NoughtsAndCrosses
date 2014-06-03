class GUIDisplay

  attr_writer :on_play

  CELL_SIZE = 150 

  def initialize(gui)
    @gui = gui
    @gui.on_click = Proc.new{ |x,y| play_at(x, y) }
  end

  def show
    @gui.display_window(4, 3, CELL_SIZE)
  end
  
  def human?(mark)
    @gui.prompt_yes_no?("Is player #{mark} human?")
  end

  def prompt_for_move
    move = @last_space_played
    @last_space_played = nil
    move
  end

  def next_move_available?
    !@last_space_played.nil?
  end

  def display_board(board)
    x = 0
    y = 0
    (0..8).each do |sq|
      @gui.draw_text(board.mark_at(sq), x, y) if board.played?(sq)
      
      x = x == 2 ? 0 : x+1 
      y += 1 if(x == 0)
    end
  end

  def display_result(board)
    if board.drawn?
      text = "It's a draw!"
    else
      text = board.winner + " wins!"
    end
    @gui.draw_text(text, 3, 0, 3)
  end
  
  def play_at(x, y)
    @last_space_played = convert_to_space(x, y)    
    @on_play.call if(@last_space_played < 9)
  end

  def convert_to_space(x, y)
    col = (x / CELL_SIZE).to_i
    row = (y / CELL_SIZE).to_i
    row * 3 + col
  end
  
end
