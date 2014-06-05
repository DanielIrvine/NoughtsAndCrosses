class GuiController 

  def initialize(gui)
    @gui = gui
  end

  def play_at(sp)
    @gui.last_space_played = sp
    @gui.play
  end
  
  def play
    @gui.play
  end

end
