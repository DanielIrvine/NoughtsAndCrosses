require 'player'

class ComputerPlayer < Player
  def initialize(mark, opponent_mark)
    super(mark)
    @opponent_mark = opponent_mark
    @best_moves = {}
  end

  def make_move(board)
    #max_depth = board.size * board.size
    max_depth = board.size * 3
    make_best_move(board, max_depth, 0, @mark, @opponent_mark)[:best_move]
  end

  def make_best_move(board, max_depth, depth, mark, opponent_mark)
    return @best_moves[board] if @best_moves.key?(board)
    return { score: score(board, mark, depth, max_depth),
             best_move: board } if board.game_over?
    return { score: 0, best_move: board } if depth == max_depth

    best_score = -(max_depth - 1)
    best_move = nil
    board.available_spaces.shuffle.each do |sp|
      new_board = board.make_move(sp, mark)
      score = -make_best_move(new_board, max_depth, depth + 1, opponent_mark, mark)[:score]
      if score > best_score
        best_score = score
        best_move = new_board
      end
    end

    insert_rotations(board, best_score, best_move)

    @best_moves[board]
  end

  def result(score, board)
    { score: score, best_move: board }
  end

  def score(board, player, depth, max_depth)
    return 0 if board.drawn?
    return max_depth - depth if board.winner == player
    -(max_depth - depth)
  end

  def insert_rotations(board, best_score, best_move)
    board.rotate_and_zip(best_move) do |rotated, rotated_best_move|
      @best_moves[rotated] = result(best_score, rotated_best_move)
    end
  end
end
