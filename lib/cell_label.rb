require 'qt'

module NoughtsAndCrosses
  module GUI
    class CellLabel < Qt::Label
      
      def initialize(index, display)
        super(nil)
        @index = index
        @display = display
        setFrameStyle(Qt::Frame::StyledPanel | Qt::Frame::Plain);
        setObjectName("square-#{index}")
      end
    
      def mousePressEvent(_)
        @display.set_next_human_move(@index)
        @display.play
        @display.play
      end
    end
  end
end
