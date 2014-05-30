require 'player'

class ComputerPlayer < Player
  def initialize(mark, opponent_mark)
    super(mark)
    @opponent_mark = opponent_mark
    @best_moves = {}
  end

  def make_move(board)
    make_best_move(board, @mark, @opponent_mark)[:best_move]
  end

  def make_best_move(board, mark, opponent_mark)
    return @best_moves[board] if @best_moves.key?(board)
    return { score: score(board, mark),
             best_move: board } if board.game_over?

    best_score = -2
    best_move = nil
    board.available_spaces.shuffle.each do |sp|
      new_board = board.make_move(sp, mark)
      score = -make_best_move(new_board, opponent_mark, mark)[:score]
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

  def score(board, player)
    return 0 if board.drawn?
    return 1 if board.winner == player
    -1
  end

  def insert_rotations(board, best_score, best_move)
    board.rotate_and_zip(best_move) do |rotated, rotated_best_move|
      @best_moves[rotated] = result(best_score, rotated_best_move)
    end
  end
end
