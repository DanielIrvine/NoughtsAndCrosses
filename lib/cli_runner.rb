class CLIRunner

  def initialize(game)
    @game = game
  end

  def play  
    @game.play_turn! until @game.game_over?
    @game.board 
  end
end
