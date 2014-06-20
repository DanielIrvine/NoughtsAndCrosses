module NoughtsAndCrosses

  class ComputerPlayer
  
    attr_reader :mark
    INF = 100
  
    def initialize(mark, opponent_mark)
      @mark = mark
      @opponent_mark = opponent_mark
    end
  
    def make_move(board)
        make_best_move(board,
                       [board.available_spaces.length, 7].min,
                       -INF,
                       INF,
                       @mark, @opponent_mark)[:best_move]
    end
    
    def make_best_move(board, depth, alpha, beta, mark, opponent_mark)
      return { score: score(board, mark, depth),
               best_move: board } if board.game_over? || depth == 0
  
      best_move = nil
      board.available_spaces.shuffle.each do |sp|
        new_board = board.make_move(sp, mark)
        score = -make_best_move(new_board, depth - 1, -beta, -alpha, opponent_mark, mark)[:score]
        if score > alpha
          alpha = score
          best_move = new_board
        end
        break if alpha >= beta
      end
  
      result(alpha, best_move)
    end
  
    def result(score, board)
      { score: score, best_move: board }
    end
  
    def score(board, player, depth)
      return 0 if board.drawn?
      score = depth + 1
      return score if board.winner == player
      -score
    end
  end
end
