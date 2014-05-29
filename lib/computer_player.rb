require 'player'

class ComputerPlayer < Player

  def initialize(mark)
    
    super(mark)
    @best_moves = Hash.new
  end
  
  def make_move(board, opponent)
    make_best_move(board, self, opponent)[:best_move]
  end
  
  def make_best_move(board, current_player, opponent)
    
    return @best_moves[board] if @best_moves.has_key?(board)
    return { :score => score(board, current_player), 
            :best_move => board } if board.game_over?

    best_score = -2
    best_move = nil
    board.available_spaces.shuffle.each do |sp|
      new_board = board.make_move(sp, current_player.mark)
      score = -make_best_move(new_board,
                              opponent, 
                              current_player)[:score]
      if score > best_score
        best_score = score
        best_move = new_board
      end
    end

    insert_rotations(board, best_score, best_move)

    return @best_moves[board]
  end

  def result(score, board)
    { :score => score, :best_move => board }
  end

  def score(board, player)
    return 0 if board.drawn?
    return 1 if board.winner == player.mark
    -1
  end

  def insert_rotations(board, best_score, best_move)
    board.rotate_and_zip(best_move) do |rotated, best_move|
      @best_moves[rotated] = result(best_score, best_move)
    end
  end
end
