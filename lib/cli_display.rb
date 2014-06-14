require 'board_io'
require 'game'
require 'strings'

module NoughtsAndCrosses
  module CLI
    class CLIDisplay

      include Strings

      def initialize(io)
        @io = io
      end

      def begin
        @controller = Game.new(human?('X'),
                               human?('O'),
                               four_by_four?)
        display_board(@controller.board)
      end
      
      def human?(mark)
        @io.puts translate(:human, mark)
        valid_answers = %w(y n)
        answer = @io.gets.chomp.downcase until valid_answers.include? answer
        answer == 'y'
      end

      def four_by_four?
        @io.puts translate(:four_by_four)
        valid_answers = %w(y n)
        answer = @io.gets.chomp.downcase until valid_answers.include? answer
        answer == 'y'
      end

      def display_board(board)
        BoardIO.new(@io, board).display
      end

      def display_result(text)
        @io.puts text
      end

      def prompt_for_move_if_necessary
        return if !@controller.next_player.kind_of?(HumanPlayer)
        @io.puts translate(:enter_square)
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
  end
end
