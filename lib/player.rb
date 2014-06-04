class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def has_available_move?
    true
  end
end
