require 'player'

class OneMovePlayer < Player

  def initialize(mark)
    super(mark)
    @has_played = false
  end

  def can_play?
    !@has_played
  end

  def make_move(board)
    @has_played = true
    board.make_move(board.available_spaces.first, @mark)
  end
end
