# NoughtsAndCrosses

This is an API for playing noughts and crosses, the game also known as Tic Tac Toe. It has the following features.

 * Unbeatable computer players
 * "Human" players which play any move
 * Support for 3x3 or 4x4 games 

## Installation

Add this line to your application's Gemfile:

    gem 'noughts_and_crosses'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noughts_and_crosses

## Usage

You must require `game.rb` to use this gem.

    require 'game'

Instantiate a `Game` instance like this:

    x_human = true          # true for X as a human player, false for computer
    o_human = false         # true for O as a human player, false for computer
    four_by_four = false    # true for a 4x4 game, false for a 3x3
    game = Game.new(x_human,
                    o_human,
                    four_by_four)

X always plays first, O always plays second. Play alternates until the game is
over.

If the next player is a `ComputerPlayer`, you can simply call `play_turn!` to make a move.

    game.play_turn!

If the next player is a `HumanPlayer`, you must first set the square to be played, and then call `play_turn!`:

    game.set_next_human_move(4)
    game.play_turn!

See below for a description of how squares are referenced.

You can determine which player is next by calling `next_player`:

    player = game.next_player
    game.play_turn! if player.kind_of?(ComputerPlayer)

Objects of type `HumanPlayer` and `ComputerPlayer` may be returned from this method. Each of these types supports the `mark` string attribute.

    player = game.next_player
    mark = player.mark  # either 'X' or 'O'

#### Referencing squares

Squares are referenced with a single index number. For a 3x3 board, these numbers run 0 to 8, and for a 4x4 board, these numbers run 0 to 15.

-- | --- | --
0 | 1 | 2
3 | 4 | 5
6 | 7 | 8


    -- | -- | -- | -- |
    0 | 1 | 2 | 3
    4 | 5 | 6 | 7
    8 | 9 | 10 | 11
    12 | 13 | 14 | 15

#### Retrieving current board state

Use the `game.board.mark_at(sq)` method to determine the current mark at a square.

    (0..8).each do |sq|
       draw_mark(sq, game.board.mark_at(sq))
    end


#### Game over

You can determine if the game is over by calling the `game_over?` method.

    puts 'Game over!' if game.game_over?

Once over, you can determine if the game was drawn or who the winner was, if it was won:

    if game.board.drawn?
       puts "It's a draw!"
    else
       puts "#{game.board.winner} wins!"
    end

## Contributing

1. Fork it ( https://github.com/[my-github-username]/noughts_and_crosses/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
