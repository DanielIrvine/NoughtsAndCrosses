require 'strings'

module NoughtsAndCrosses
  module BoardStrings

    include Strings

    def result_text(board)
      if board.drawn?
        translate(:draw)
      else
        translate(:winner, board.winner)
      end
    end
  end
end
