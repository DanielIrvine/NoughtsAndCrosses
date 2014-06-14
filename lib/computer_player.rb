module NoughtsAndCrosses

  class ComputerPlayer
  
    attr_reader :mark
    INF = 100
  
    def initialize(mark, opponent_mark)
      @mark = mark
      @opponent_mark = opponent_mark
    end
  
    def make_move(board)
      moves_to_win = board.size * 2 - 3
      random_play_limit = board.available_spaces.length - moves_to_win
      random_play_cap = [11, random_play_limit].max
      if(board.available_spaces.length > random_play_cap)
        make_random_move(board)
      else
        make_best_move(board,
                       [board.available_spaces.length + 1, 7].min,
                       -INF,
                       INF,
                       @mark, @opponent_mark)[:best_move]
      end
    end
    
    def make_random_move(board)
      board.make_move(board.available_spaces.sample, @mark)
    end
  
    def make_best_move(board, depth, alpha, beta, mark, opponent_mark)
      return { score: 0, best_move: board } if depth == 0
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
        break if best_score >= beta
      end
  
      result(best_score, best_move)
    end
  
    def result(score, board)
      { score: score, best_move: board }
    end
  
    def score(board, player, depth)
      return 0 if board.drawn?
      return depth if board.winner == player
      -depth
    end
  end
end
