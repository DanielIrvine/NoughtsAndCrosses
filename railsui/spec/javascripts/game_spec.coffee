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
