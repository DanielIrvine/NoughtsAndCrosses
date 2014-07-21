class @Game

  constructor: (@dom = $(document.body), @url = '') ->

  convert_square: (square) ->
    if square == "-" then {link: true} else {text: square}

  convert_board: (json) ->
    @convert_square(square) for square in json.board

  set_square: (sq, index, finished) ->
    elem = $("#sq-#{index}", @dom).find('a')
    if sq.link && !finished
      elem.on 'click', => @make_move(index)
    else
      elem.off 'click'
    elem.text sq.text
  
  set_status: (status) ->
    $("#status", @dom).text status if status

  parse: (json) ->
    @set_square(sq, i, json.finished) for sq, i in @convert_board(json)
    @set_status(json.status_text)
    setTimeout (=> @make_move('')), 1000 if @should_play_next_computer_move(json)

  should_play_next_computer_move: (json) ->
    json.next_move == "computer" && !json.finished

  make_move: (sq) ->
    @parse_ajax "/make_move?sq=" + sq

  start: ->
    @parse_ajax "/get_board?" + @url_args()

  parse_ajax: (action) ->
    $.ajax { url: @url_root() + action, success: (json) => @parse(json) }

  url_args: ->
    @url.split('?')[1]

  url_root: ->
    loc = @url.lastIndexOf('/')
    if loc == -1 then '' else @url.slice(0, loc)
