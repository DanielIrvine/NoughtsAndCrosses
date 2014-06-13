require 'play_timer'

module NoughtsAndCrosses
  module GUI
    class TestPlayTimer < PlayTimer
    
      def start(_)
    
      end
    
      def fire 
        emit timeout()
      end
    end
  end
end
