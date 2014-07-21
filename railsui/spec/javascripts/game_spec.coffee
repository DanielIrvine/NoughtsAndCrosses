#= require game
describe "Game", ->
  it "converts an empty square to a link", ->
    expect( new Game().convert_board({board:"-"}) ).toEqual([{link:true}])
