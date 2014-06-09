require 'qt'

class PlayTimer < Qt::Timer

  slots :play

  def initialize(controller)
    super(nil)

    @controller = controller
    connect(self, SIGNAL(:timeout), self, SLOT(:play))
    start(1000)
  end

  def play
    @controller.play_turn
  end
end
