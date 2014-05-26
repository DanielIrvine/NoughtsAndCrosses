require './player'

class HumanPlayerStrategy

  def initialize(display)
    @display = display
  end

  def make_move(board, this_player, opponent)
    board.make_move(@display.get_valid_move(board), this_player.mark) 
  end
end
