class ComputerPlayer

  attr_reader :mark
  INF = 100

  def initialize(mark, opponent_mark)
    @mark = mark
    @opponent_mark = opponent_mark
    @best_moves = {}
  end

  def make_move(board)
    moves_to_win = board.size * 2 - 3
    random_play_limit = board.available_spaces.length - moves_to_win
    random_play_cap = [11, random_play_limit].max
    if(board.available_spaces.length > random_play_cap)
      make_random_move(board)
    else
      make_best_move(board,
                     board.available_spaces.length + 1,
                     @mark, @opponent_mark)[:best_move]
    end
  end
  
  def make_random_move(board)
    board.make_move(board.available_spaces.sample, @mark)
  end

  def make_best_move(board, depth, mark, opponent_mark)
    return { score: 0, best_move: board } if depth == 0
    return @best_moves[board] if @best_moves.key?(board)
    return { score: score(board, mark, depth),
             best_move: board } if board.game_over?

    best_score = -INF 
    best_move = nil
    board.available_spaces.shuffle.each do |sp|
      new_board = board.make_move(sp, mark)
      score = -make_best_move(new_board, depth - 1, opponent_mark, mark)[:score]
      if score > best_score
        best_score = score
        best_move = new_board
      end
    end

    @best_moves[board] = result(best_score, best_move)
    insert_rotations(board, best_score, best_move)

    @best_moves[board]
  end

  def result(score, board)
    { score: score, best_move: board }
  end

  def score(board, player, depth)
    return 0 if board.drawn?
    return depth if board.winner == player
    -depth
  end

  def insert_rotations(board, best_score, best_move)
    board.rotate_and_zip(best_move) do |rotated, rotated_best_move|
      @best_moves[rotated] = result(best_score, rotated_best_move)
    end
  end
end
