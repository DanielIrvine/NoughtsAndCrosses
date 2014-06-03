class GUIDisplay

  attr_writer :on_play

  BOARD_SIZE = 600
  RESULT_SIZE = 60

  def initialize(gui)
    @gui = gui
    @gui.on_click = Proc.new{ |x,y| play_at(x, y) }
  end

  def show
    @gui.display_window(BOARD_SIZE, BOARD_SIZE + RESULT_SIZE)
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
    @on_play.call
  end

  def convert_to_space(x, y)
    square_size = BOARD_SIZE / 3
    row = (x / square_size).to_i
    col = (y / square_size).to_i
    row * 3 + col
  end
  
end
