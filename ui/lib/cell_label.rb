require 'qt'

module NoughtsAndCrosses
  module GUI
    class CellLabel < Qt::Label
      
      def initialize(index, parent)
        super(nil)
        @index = index
        @parent = parent
        self.frame_style = Qt::Frame::StyledPanel | Qt::Frame::Plain
        self.object_name = "square-#{index}"
      end
    
      def mousePressEvent(_)
        return if @parent.game.game_over?
        @parent.set_next_human_move(@index)
        @parent.play
        @parent.play
      end
    end
  end
end
