require 'qt'

module NoughtsAndCrosses
  module GUI
    class PlayTimer < Qt::Timer
    
      slots :play
    
      def initialize(parent)
        super(nil)
    
        @parent = parent
        connect(self, SIGNAL(:timeout), self, SLOT(:play))
      end
    
      def play
        @parent.play
      end
    end
  end
end
