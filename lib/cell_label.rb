require 'qt'

module NoughtsAndCrosses
  module GUI
    class CellLabel < Qt::Label
      
      CELL_SIZE = 150

      def initialize(index, parent)
        super(nil)
        @index = index
        @parent = parent
        self.frame_style = Qt::Frame::StyledPanel | Qt::Frame::Plain
        self.object_name = "square-#{index}"
        self.minimum_height = CELL_SIZE
        self.minimum_width = CELL_SIZE
      end
    
      def mousePressEvent(_)
        @parent.set_next_human_move(@index)
        @parent.play
        @parent.play
      end
    end
  end
end
