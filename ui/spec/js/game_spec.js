describe("game", function(){

  it("converts a string to an array of HTML segments", function() {
    expect(convert_board({board:"-"})).toEqual(
      ["make_move?sq=0&board=-"])
  });

  it("converts all squares", function() {
    expect(convert_board({board:"---"})).toEqual(
      ["make_move?sq=0&board=---",
      "make_move?sq=1&board=---",
      "make_move?sq=2&board=---"])
  });

  it("displays X", function() {
    expect(convert_board({board:"X"})).toEqual(["X"])
  });

  it("displays O", function() {
    expect(convert_board({board: "O"})).toEqual(["O"]);
  });
});
