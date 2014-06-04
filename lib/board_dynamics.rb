class BoardDynamics

  attr_reader :size, :transforms, :winning_combos

  def initialize(size)
    @size = size
    @transforms = calculate_transforms
    @winning_combos = calculate_winning_combos
  end

  def calculate_transforms
    rotations = [] 
    rotations << winning_rows
    3.times { rotations << rotate_right(rotations.last) }

    flips = []
    flips << winning_rows.reverse
    flips << winning_rows.map(&:reverse)
    flips << rotate_right(winning_rows).reverse
    flips << rotate_right(winning_rows).map(&:reverse)
    flatten_transforms(rotations + flips)
  end

  def flatten_transforms(a)
    transforms = []
    a.each do |r|
      transforms << r.flatten
    end
    transforms
  end

  def rotate_right(a)
    a.transpose.reverse
  end

  def winning_rows
    all_indexes.to_a.each_slice(@size).to_a
  end
 
  def all_indexes
    (0..@size*@size-1)
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
end
