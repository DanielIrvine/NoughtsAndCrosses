require 'qt'

class CellLabel < Qt::Label
  
  def initialize(index, parent)
    super(nil)
    @index = index
    @parent = parent
    setFrameStyle(Qt::Frame::StyledPanel | Qt::Frame::Plain);
  end

  def mousePressEvent(_)
    @parent.set_next_human_move(@index)
    @parent.play_turn
  end
end
