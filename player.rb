class Player

  attr_reader :mark

	def initialize(mark, strategy, game)
    @mark = mark
    @strategy = strategy
    @game = game
  end

  def make_move(board)
    @strategy.make_move(board, self, @game.opponent_of(self))
  end

  def make_best_move(board, opponent)
    board.make_move(board.available_spaces.first, @mark)
  end

end
