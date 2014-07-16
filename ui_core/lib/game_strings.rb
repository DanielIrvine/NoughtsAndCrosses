require 'strings'

module NoughtsAndCrosses
  class GameStrings

    def self.result_text(board)
      if board.drawn?
        Strings.translate(:draw)
      else
        Strings.translate(:winner, board.winner)
      end
    end

    def self.play_turn_text(game)
      if game.next_player.kind_of?(HumanPlayer)
        Strings.translate(:human_move, game.next_player.mark)
      else
        Strings.translate(:computer_move, game.next_player.mark)
      end
    end
  end
end
