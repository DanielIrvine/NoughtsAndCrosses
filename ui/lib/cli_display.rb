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
        @game = Game.new(human?('X'),
                         human?('O'),
                         four_by_four?)
        display_board(@game.board)
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
        return if !@game.next_player.kind_of?(HumanPlayer)
        @io.puts translate(:enter_square)
        square = @io.gets.to_i - 1
        @game.set_next_human_move(square)
      end
      
      def exec
        while !@game.game_over? 
          prompt_for_move_if_necessary
          board = @game.play_turn!
          display_board(board)
        end
        display_result(result_text)
      end

      def result_text
        if @game.board.drawn?
          translate(:draw)
        else
          translate(:winner, @game.board.winner)
        end
      end
    end
  end
end
