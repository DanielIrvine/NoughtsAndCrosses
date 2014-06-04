class Board

  attr_reader :size

  WINNING_TRIPLETS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                      [0, 3, 6], [1, 4, 7], [2, 5, 8],
                      [0, 4, 8], [2, 4, 6]]

  ROTATIONS = [ # identity
    [0, 1, 2, 3, 4, 5, 6, 7, 8],
    # rotations
    [2, 5, 8, 1, 4, 7, 0, 3, 6],
    [8, 7, 6, 5, 4, 3, 2, 1, 0],
    [6, 3, 0, 7, 4, 1, 8, 5, 2],
    # mirrored
    [2, 1, 0, 5, 4, 3, 8, 7, 6],
    [6, 7, 8, 3, 4, 5, 0, 1, 2],
    [8, 5, 2, 7, 4, 1, 6, 3, 0],
    [0, 3, 6, 1, 4, 7, 2, 5, 8]]

  UNPLAYED_SQUARE = '-'

  def initialize(board, size = 3)
    @board = board
    @size = size
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
    triplet = WINNING_TRIPLETS.find { |t| played?(t[0]) && squares_equal?(t) }
    triplet ? mark_at(triplet[0]) : nil
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
    Board.new(new_board, @size)
  end

  def available_spaces
    (0..8).select { |sp| @board[sp] == UNPLAYED_SQUARE }
  end

  def played?(square)
    @board[square] != UNPLAYED_SQUARE
  end

  def squares_equal?(a)
    a.map { |sq| @board[sq] }.uniq.length == 1
  end

  def played_spaces
    (0..8).to_a - available_spaces
  end

  def mark_at(sp)
    @board[sp]
  end

  def rotate_by(rotation)
    new_board = ''
    (0..8).each do |sq|
      new_board[sq] = @board[rotation[sq]]
    end
    Board.new(new_board, @size)
  end

  def all_rotations
    @all_rotations ||= ROTATIONS.map { |r| rotate_by(r) }
  end

  def rotate_and_zip(next_board, &block)
    ROTATIONS.each { |r| block.call([rotate_by(r), next_board.rotate_by(r)]) }
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
