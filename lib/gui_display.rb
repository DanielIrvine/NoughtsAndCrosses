require 'play_timer'
require 'game'
require 'strings'

module NoughtsAndCrosses
  module GUI
    class GUIDisplay
    
      include Strings

      def initialize(window, dialog, timer)
        @window = window
        @dialog = dialog
        @timer= timer
      end
    
      def begin
        
        @controller = Game.new(human?('X'),
                               human?('O'),
                               four_by_four?)
        @window.display_window(@controller.board.size + 1,
                               @controller.board.size,
                               self)
        @timer.use(self)
      end
    
      def four_by_four?
        @dialog.ask(translate(:four_by_four))
      end
      
      def human?(mark)
        @dialog.ask(translate(:human, mark))
      end
    
      def display_board(board)
        board.all_indexes.each do |sq|
          @window.draw_square(board.mark_at(sq), sq) if board.played?(sq)
        end
      end
    
      def display_result(result_text)
        @window.draw_result(result_text)
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
  end
end
