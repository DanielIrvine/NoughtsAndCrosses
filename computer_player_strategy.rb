require './player'

class ComputerPlayerStrategy

  def make_move(board, this_player, opponent)
    score, board = this_player.make_best_move(board, opponent)
    board
  end
end
