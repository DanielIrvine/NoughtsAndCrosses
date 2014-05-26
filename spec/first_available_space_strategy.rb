class FirstAvailableSpaceStrategy

  def make_move(board, this_player, opponent)
    board.make_move(board.available_spaces.first, this_player.mark)
  end
end
