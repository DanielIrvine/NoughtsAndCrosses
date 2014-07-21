class @Game
  convert_square: (square) ->
    if square == "-" then {link: true} else {text: square}

  convert_board: (json) ->
    @convert_square(square) for square in json.board

  parse: (json) ->
    $.ajax { url : "/make_move?sq=" } if json.next_move == "computer"
