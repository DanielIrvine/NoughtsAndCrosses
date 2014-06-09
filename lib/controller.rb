require 'human_player'
require 'computer_player'
require 'game'

class Controller

  def initialize(game = nil)
    @game = game
  end
    
  def begin(x_human, o_human, size)
    x = build_player('X', x_human)
    o = build_player('O', o_human)
    @game = Game.new(x, o, Board.with_size(size))
    @game.board
  end

  def play_turn!
    @game.play_turn!
  end

  def game_over?
    @game.game_over?
  end

  def next_player
    @game.next_player
  end

  def set_next_human_move(square)
    player = @game.next_player
    player.next_move = square if player.kind_of?(HumanPlayer)
  end

  def result_text
    @game.result_text
  end

  def build_player(mark, human)
    if human
      HumanPlayer.new(mark)
    else
      ComputerPlayer.new(mark, opponent_of(mark))
    end
  end

  def opponent_of(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
