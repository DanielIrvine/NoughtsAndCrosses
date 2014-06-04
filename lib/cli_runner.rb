class CLIRunner

  def initialize(game)
    @game = game
  end

  def play  
    @game.play_all! until @game.board.game_over?
    @game.board 
  end
end
