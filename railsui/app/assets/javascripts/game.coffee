class @Game

  constructor: (@dom = $(document.body)) ->

  convert_square: (square) ->
    if square == "-" then {link: true} else {text: square}

  convert_board: (json) ->
    @convert_square(square) for square in json.board

  set_square: (sq, index) ->
    elem = $("#sq-#{index}", @dom).find('a')
    if sq.link
      elem.on 'click', => @make_move(index)
    else
      elem.off 'click'
    elem.text sq.text

  parse: (json) ->
    @set_square(sq, i) for sq, i in @convert_board(json)
    @make_move('') if json.next_move == "computer"

  make_move: (sq) ->
    $.ajax { url: "/make_move?sq=" + sq }
