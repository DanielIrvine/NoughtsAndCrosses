require 'play_timer'

class TestPlayTimer < PlayTimer

  def start(_)

  end

  def fire 
    emit timeout()
  end
end
