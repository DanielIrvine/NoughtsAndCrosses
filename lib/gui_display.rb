require 'play_timer'
require 'game'

class GUIDisplay

  def initialize(gui, dialog, timer_type)
    @gui = gui
    @dialog = dialog
    @timer_type = timer_type
  end

  def begin
    
    @controller = Game.new(human?('X'),
                           human?('O'),
                           size?)
    @gui.display_window(@controller.board.size + 1,
                        @controller.board.size,
                        self)
    @timer_type.new(self)
  end

  def size?
    result = @dialog.ask('Do you want to play a 4x4 game? Choose no for a 3x3 game.')
    result ? 4 : 3
  end

  def human?(mark)
    @dialog.ask("Is player #{mark} human?")
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
