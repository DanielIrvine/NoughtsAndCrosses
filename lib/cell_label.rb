require 'qt'

module NoughtsAndCrosses
  module GUI
    class CellLabel < Qt::Label
      
      def initialize(index, parent)
        super(nil)
        @index = index
        @parent = parent
        setFrameStyle(Qt::Frame::StyledPanel | Qt::Frame::Plain);
        setObjectName("square-#{index}")
      end
    
      def mousePressEvent(_)
        @parent.set_next_human_move(@index)
        @parent.play_turn
        @parent.play_turn
      end
    end
  end
end
