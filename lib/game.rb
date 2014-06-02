require 'board'
require 'display'

class Game
  attr_reader :board
  attr_reader :player_x, :player_o

  def initialize(player_x, player_o, display)
    @board = Board.start
    @player_x = player_x
    @player_o = player_o
    @display = display
  end

  def play_turn!
    next_board = next_player.make_move(@board)
    @board = next_board if !next_board.nil?
    @display.display_board(@board)
    @board
  end

  def play_all!
    @display.display_board(@board)

    play_turn! until (@board.game_over? || !next_player.can_play?)

    if @board.game_over?
      @display.display_result(@board)
    end
    @board.winner
  end

  def next_player
    @board.played_spaces.length.even? ? @player_x : @player_o
  end
end
