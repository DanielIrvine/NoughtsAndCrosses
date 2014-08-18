#= require vendor/URI

window.NoughtsAndCrosses = {}

class NoughtsAndCrosses.Game

  constructor: (@dom = $(document.body), @url = '') ->
    uri = new URI(@url)
    @urlArgs = uri.query()
    @urlRoot = uri.filename('').query('')

  convertSquare: (square) ->
    if square == "-" then {link: true} else {text: square}

  convertBoard: (json) ->
    @convertSquare(square) for square in json.board

  setSquare: (sq, index, finished) ->
    elem = $("[data-id='sq-#{index}']", @dom).find('a')
    elem.empty
    elem.off 'click'
    if sq.link && !finished
      elem.on 'click', => @makeMove(index)
    elem.text sq.text

  setStatus: (status) ->
    $("[data-id='status']", @dom).text status if status

  parse: (json) ->
    @setSquare(sq, i, json.finished) for sq, i in @convertBoard(json)
    @setStatus(json.status_text)
    setTimeout (=> @makeMove('')), 1000 if @shouldPlayComputerMove(json)

  shouldPlayComputerMove: (json) ->
    json.next_move == "computer" && !json.finished

  makeMove: (sq) ->
    @parseAjax "make_move?sq=" + sq

  start: ->
    @parseAjax "get_board?" + @urlArgs

  parseAjax: (action) ->
    $.ajax { url: @urlRoot + action, success: (json) => @parse(json) }
