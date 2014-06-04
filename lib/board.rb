class Board

  attr_reader :size

  UNPLAYED_SQUARE = '-'

  def initialize(board, size = 3, winning_combos = nil, transforms = nil)
    @board = board
    @size = size
    @winning_combos = winning_combos || calculate_winning_combos
    @transforms = transforms || calculate_transforms
  end

  def self.with_size(size)
    str = ''
    (size*size).times { str << UNPLAYED_SQUARE }
    Board.new(str, size)
  end

  def rotate_right(a)
    a.transpose.reverse
  end

  def calculate_transforms
    all_rotations = [] 
    all_rotations << winning_rows
    3.times { all_rotations << rotate_right(all_rotations.last) }

    all_rotations << winning_rows.reverse
    all_rotations << winning_rows.map(&:reverse)
    all_rotations << rotate_right(winning_rows).reverse
    all_rotations << rotate_right(winning_rows).map(&:reverse)
    flatten_transforms(all_rotations)
  end

  def flatten_transforms(a)
    transforms = []
    a.each do |r|
      transforms << r.flatten
    end
    transforms
  end
  
  def won?
    winner != nil
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

  def calculate_winning_combos
    winning_rows + winning_columns + winning_diagonals
  end
  
  def winner
    combo = @winning_combos.find { |t| played?(t[0]) && squares_equal?(t) }
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

  def rotate_by(rotation)
    new_board = ''
    all_indexes.each do |sq|
      new_board[sq] = @board[rotation[sq]]
    end
    build_board(new_board)
  end

  def build_board(new_board)
    Board.new(new_board, @size, @winning_combos, @transforms)
  end

  def rotate_and_zip(next_board, &block)
    @transforms.each { |r| block.call([rotate_by(r), next_board.rotate_by(r)]) }
  end

  def all_indexes
    (0..@size*@size-1)
  end

  def to_s
    @board
  end

  def hash
    @board.hash
  end

  def ==(other)
    @board = other.to_s
  end

  alias_method :eql?, :==
end
