class Player

  attr_reader :mark

	def initialize(mark, strategy, game, best_moves = nil)
    @mark = mark
    @strategy = strategy
    @game = game
    @best_moves = best_moves
  end

  def make_move(board)
    @strategy.make_move(board, self, @game.opponent_of(self))
  end

  def make_best_move(board, opponent)
    
    return @best_moves[board] if @best_moves.has_key?(board)
    return hash_from(score(board), board) if board.game_over?

    best_score = -2
    best_move = nil
    board.available_spaces.each do |sp|
      new_board = board.make_move(sp, @mark)
      score = -opponent.make_best_move(new_board, self)[:score]
      if score > best_score
        best_score = score
        best_move = new_board
      end
    end

    return @best_moves[board] = hash_from(best_score, best_move)
  end

  def hash_from(score, board)
    { :score => score, :board => board }
  end

  def score(board)
    return 0 if board.drawn?
    return 1 if board.winner == @mark
    -1
  end
end
