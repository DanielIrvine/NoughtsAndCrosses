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
    
    return score(board), board if board.game_over?

    best_score = -2
    best_move = nil
    board.available_spaces.each do |sp|
      new_board = board.make_move(sp, @mark)
      score, their_board = opponent.make_best_move(new_board, self)
      score = -score
      if score > best_score
        best_score = score
        best_move = new_board
      end
    end

    return best_score, best_move
  end

  def score(board)
    return 0 if board.drawn?
    return 1 if board.winner == @mark
    -1
  end
end
