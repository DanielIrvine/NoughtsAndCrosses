require './player'

class ComputerPlayerStrategy

  def make_move(board, this_player, opponent)
    this_player.make_best_move(board, opponent)[:best_move]
  end
end
