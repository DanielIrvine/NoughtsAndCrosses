require './player'

class ComputerPlayer < Player

  def make_move(board)
    make_best_move(board)
  end
end
