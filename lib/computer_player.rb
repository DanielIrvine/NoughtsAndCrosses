require 'player'

class ComputerPlayer < Player

  INF = 100

  def initialize(mark, opponent_mark)
    super(mark)
    @opponent_mark = opponent_mark
    @best_moves = {}
  end

  def make_move(board)
    make_best_move(board,
                   board.available_spaces.length + 1,
                   -INF,
                   INF,
                   @mark, @opponent_mark)[:best_move]
  end

  def make_best_move(board, depth, alpha, beta, mark, opponent_mark)
    #return @best_moves[board] if @best_moves.key?(board)
    return { score: score(board, mark, depth),
             best_move: board } if board.game_over?

    best_score = -INF 
    best_move = nil
    board.available_spaces.shuffle.each do |sp|
      new_board = board.make_move(sp, mark)
      score = -make_best_move(new_board, depth - 1, -beta, -alpha, opponent_mark, mark)[:score]
      if score > best_score
        best_score = score
        best_move = new_board
      end
      alpha = [best_score, alpha].max
      break if (best_score >= beta)
    end

    #@best_moves[board] = result(best_score, best_move)
    #insert_rotations(board, best_score, best_move)

    result(best_score, best_move)
    #@best_moves[board]
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
