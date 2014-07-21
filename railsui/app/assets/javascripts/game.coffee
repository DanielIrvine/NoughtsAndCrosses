class @Game
  convert_square: (square) ->
    if square == "-" then {link: true} else {text: square}

  convert_board: (board) ->
    @convert_square(square) for square in board.board


