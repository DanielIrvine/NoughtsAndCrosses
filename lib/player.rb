class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def can_play?
    true
  end
end
