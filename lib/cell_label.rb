require 'qt'

class CellLabel < Qt::Label
  
  def initialize(index, controller)
    super(nil)
    @index = index
    @controller = controller
    setFrameStyle(Qt::Frame::StyledPanel | Qt::Frame::Plain);
  end

  def mousePressEvent(_)
    @controller.play_at(@index)
  end
end
