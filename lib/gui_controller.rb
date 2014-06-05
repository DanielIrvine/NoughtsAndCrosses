class GuiController 

  def initialize(gui)
    @gui = gui
  end

  def play_at(sp)
    @gui.play_at(sp)
  end
  
  def play
    @gui.play
  end

end
