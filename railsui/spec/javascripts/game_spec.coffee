#= require game

describe 'Game', ->
  DRAW_STATUS_TEXT = "It's a draw!"
  LINK = {link: true}
  SINGLE_SQUARE_BOARD = {board: "-"}
  SINGLE_SQUARE_PAGE = $('<div><div id="sq-0"><a/></div>')
  STATUS_ONLY_PAGE = $('<div><div id="status" /></div>')
  THREE_SQUARE_PAGE = $('<div><div id="sq-0"><a/></div>
    <div id="sq-1"><a/></div>
    <div id="sq-2"><a/></div></div>')
  URL_ROOT = 'http://test/test/'

  game = undefined

  lastUrlCall = ->
    $.ajax.mostRecentCall.args[0]["url"]

  waitOneSecond = ->
    jasmine.Clock.tick(1000)

  beforeEach ->
    jasmine.Clock.useMock()

  describe "stubbed ajax request", ->
    beforeEach ->
      spyOn($, "ajax")

    describe "empty page", ->
      beforeEach ->
        game = new NoughtsAndCrosses.Game()

      it "converts an empty square to a link", ->
        expect(game.convertBoard(SINGLE_SQUARE_BOARD)).toEqual([LINK])

      it "converts all squares", ->
        expect(game.convertBoard({board:"---"})).toEqual(LINK for [1..3])

      it "displays X", ->
        expect(game.convertBoard({board:"X"})).toEqual([{text: "X"}])

      it "displays O", ->
        expect(game.convertBoard({board:"O"})).toEqual([{text: "O"}])

      it "does not make an AJAX request for a human player", ->
        game.parse SINGLE_SQUARE_BOARD
        expect($.ajax.callCount).toEqual(0)

      it "makes an AJAX request when a square is clicked", ->
        game.makeMove(1)
        expect(lastUrlCall()).toContain("make_move?sq=1")

      it "does not make a request if the next player is computer and the game is finished", ->
        game.parse {board:"XXXOO----", next_move: "computer", finished: true}
        waitOneSecond()
        expect($.ajax.callCount).toEqual 0

    describe "single square page", ->

      clickSquare = () ->
        $('#sq-0', SINGLE_SQUARE_PAGE).find('a').trigger('click')

      beforeEach ->
        game = new NoughtsAndCrosses.Game(SINGLE_SQUARE_PAGE)

      it "sets square link when parsing json", ->
        game.parse SINGLE_SQUARE_BOARD
        clickSquare()
        expect($.ajax.callCount).toEqual 1

      it "unsets click handler", ->
        game.parse {board:"X"}
        clickSquare()
        expect($.ajax.callCount).toEqual 0

      it "has no links if game is finished", ->
        game.parse {board:"-", finished: true}
        clickSquare()
        expect($.ajax.callCount).toEqual 0

    describe "other page elements", ->

      textFor = (elem, page) ->
        $("#{elem}", page).text()

      it "displays status text", ->
        new NoughtsAndCrosses.Game(STATUS_ONLY_PAGE).parse {board:"XXOOOXXOX", status_text: DRAW_STATUS_TEXT}
        expect(textFor('#status', STATUS_ONLY_PAGE)).toEqual DRAW_STATUS_TEXT

      it "sets square content when parsing json", ->
        new NoughtsAndCrosses.Game(THREE_SQUARE_PAGE).parse {board:"X-O"}
        expect(textFor('#sq-0', THREE_SQUARE_PAGE)).toEqual "X"
        expect(textFor('#sq-2', THREE_SQUARE_PAGE)).toEqual "O"

      it "makes request for initial board when game is started", ->
        new NoughtsAndCrosses.Game('', "?args").start()
        expect(lastUrlCall()).toEqual "get_board?args"

    describe "url tests", ->

      beforeEach ->
        game = new NoughtsAndCrosses.Game('', URL_ROOT + "game?args")

      it "starts at location using existing path", ->
        game.start()
        expect(lastUrlCall()).toEqual URL_ROOT + "get_board?args"

      it "makes move at location using existing path", ->
        game.makeMove(1)
        expect(lastUrlCall()).toContain URL_ROOT + "make_move?"

  describe "fake ajax request", ->

    it "makes an AJAX request for a computer player", ->
      bestMoveCall = ''
      spyOn($, "ajax").andCallFake (opts) -> bestMoveCall = opts.url
      new NoughtsAndCrosses.Game().parse {board:"-", next_move: "computer"}
      waitOneSecond()
      expect(bestMoveCall).toContain("make_move?sq=")

