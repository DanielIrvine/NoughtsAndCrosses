require 'player'

class DefinedSequencePlayer < Player

  def initialize(mark, sequence)
    super(mark)
    @sequence = sequence
  end
  
  def make_move(board)
    board.make_move(@sequence.shift, mark)
  end
end
