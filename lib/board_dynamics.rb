module NoughtsAndCrosses

  class BoardDynamics
  
    attr_reader :size, :winning_combos
  
    def initialize(size)
      @size = size
      @winning_combos = calculate_winning_combos
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
  end
