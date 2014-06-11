require 'qt'

class PlayTimer < Qt::Timer

  slots :play

  def initialize
    super(nil)

    connect(self, SIGNAL(:timeout), self, SLOT(:play))
  end

  def use(display)
    @display = display
    start(1000)
  end

  def play
    @display.play_turn
  end
end
