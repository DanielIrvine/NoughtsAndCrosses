class PlayTimer < Qt::Timer

  slots :play

  def initialize(parent, controller)
    super(parent)

    @controller = controller
    connect(self, SIGNAL(:timeout), self, SLOT(:play))
    start(1000)
  end

  def play
    @controller.play
  end
end
