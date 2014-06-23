module NoughtsAndCrosses
  class Board
  
    attr_reader :size
    UNPLAYED_SQUARE = '-'
    VALID_MARKS = %w{X O -} 
    
    def initialize(board, size = nil)
      @board = board
      @size = size || Math.sqrt(board.length).to_i
    end
  
    def self.valid_board_str(board_str)
      valid_size(board_str) && all_valid_marks(board_str)
    end

    def self.all_valid_marks(board_str)
      board_str.split('').all?{|sq| VALID_MARKS.include?(sq) }
    end

    def self.valid_size(board_str)
      size = Math.sqrt(board_str.length)
      size.to_i == size
    end

    def self.with_size(size)
      str = ''
      (size*size).times { str << UNPLAYED_SQUARE }
      Board.new(str, size)
    end
  
    def won?
      winner != nil
    end
  
    def winner
      combo = winning_combos.find { |t| played?(t[0]) && squares_equal?(t) }
      combo ? mark_at(combo[0]) : nil
    end
  
    def drawn?
      !won? && !available_spaces?
    end
  
    def game_over?
      won? || !available_spaces?
    end
  
    def available_spaces?
      @board.split('').any? { |sq| sq == UNPLAYED_SQUARE }
    end
  
    def make_move(sq, player_mark)
      return self if !available_spaces.include?(sq)
      new_board = String.new(@board)
      new_board[sq] = player_mark
      build_board(new_board)
    end
  
    def available_spaces
      all_indexes.select { |sp| @board[sp] == UNPLAYED_SQUARE }
    end
  
    def played?(square)
      @board[square] != UNPLAYED_SQUARE
    end
  
    def squares_equal?(a)
      a.map { |sq| @board[sq] }.uniq.length == 1
    end
  
    def played_spaces
      all_indexes.to_a - available_spaces
    end
  
    def mark_at(sp)
      @board[sp]
    end
  
    def build_board(new_board)
      Board.new(new_board)
    end
  
    def all_indexes
      (0..@size*@size-1)
    end

    def winning_rows
      all_indexes.to_a.each_slice(@size).to_a
    end
   
    def winning_columns
      winning_rows.transpose
    end
  
    def winning_diagonals
      [ winning_rows.map.with_index { |row, i| row[i] },
        winning_rows.map.with_index { |row, i| (row.reverse)[i] } ]
    end

    def winning_combos
      winning_rows + winning_columns + winning_diagonals
    end

    def to_s
      @board
    end
  end
end

