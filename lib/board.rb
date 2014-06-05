require 'board_dynamics'

class Board

  UNPLAYED_SQUARE = '-'

  def initialize(board, dynamics = nil)
    @board = board
    @dynamics = dynamics || BoardDynamics.new(Math.sqrt(board.length).to_i)
  end

  def self.with_size(size)
    str = ''
    (size*size).times { str << UNPLAYED_SQUARE }
    Board.new(str, BoardDynamics.new(size))
  end

  def won?
    winner != nil
  end

  def winner
    combo = @dynamics.winning_combos.find { |t| played?(t[0]) && squares_equal?(t) }
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
    Board.new(new_board, @dynamics)
  end

  def rotate_and_zip(next_board, &block)
    @dynamics.transforms.each { |r| block.call([rotate_by(r), next_board.rotate_by(r)]) }
  end

  def all_indexes
    @dynamics.all_indexes
  end
    
  def size
    @dynamics.size
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
