#= require game

describe "Game", ->
  it "converts an empty square to a link", ->
    expect( new Game().convert_board({board:"-"}) ).toEqual([{link:true}])

  it "converts all squares", ->
    expect( new Game().convert_board({board:"---"}) ).toEqual(
      [{link:true}, {link:true}, {link:true}])

  it "displays X", ->
    expect( new Game().convert_board({board:"X"}) ).toEqual([{text: "X"}])

  it "displays O", ->
    expect( new Game().convert_board({board:"O"}) ).toEqual([{text: "O"}])

  it "makes an AJAX request for a computer player", ->
    jasmine.Clock.useMock()
    bestMoveCall = ''
    spyOn($, "ajax").andCallFake (opts) -> bestMoveCall = opts.url
    new Game().parse {board:"-", next_move: "computer"}
    jasmine.Clock.tick(1000)
    expect(bestMoveCall).toContain("/make_move?sq=")

  it "does not make an AJAX request for a human player", ->
    spyOn($, "ajax")
    new Game().parse {board:"-" }
    expect($.ajax.callCount).toEqual(0)

  it "makes an AJAX request when a square is clicked", ->
    spyOn($, "ajax")
    new Game().make_move(1)
    expect($.ajax.mostRecentCall.args[0]["url"]).toContain("/make_move?sq=1")

  it "sets square content when parsing json", ->
    body = $('<div><div id="sq-0"><a/></div>
      <div id="sq-1"><a/></div>
      <div id="sq-2"><a/></div></div>')
    new Game(body).parse {board:"X-O"}
    expect($('#sq-0', body).text()).toEqual "X"
    #expect($('#sq-1').find('a')).toBeEmpty
    expect($('#sq-2', body).text()).toEqual "O"
