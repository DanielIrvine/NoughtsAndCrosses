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

