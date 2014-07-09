describe("game", function(){

  it("converts a string to an array of HTML segments", function() {
    expect(convertBoard({board:"-"})).toEqual(
      ["make_move?sq=0&board=-"])
  });

  it("converts all squares", function() {
    expect(convertBoard({board:"---"})).toEqual(
      ["make_move?sq=0&board=---",
      "make_move?sq=1&board=---",
      "make_move?sq=2&board=---"])
  });

  it("displays X", function() {
    expect(convertBoard({board:"X"})).toEqual(["X"])
  });

  it("displays O", function() {
    expect(convertBoard({board: "O"})).toEqual(["O"]);
  });

  it("does not display links for a computer move", function() {
    expect(convertBoard({board: "-", next_move: "computer"})).toEqual([""]);
  });

  it("displays already played squares for a computer move", function() {
    expect(convertBoard({board: "X", next_move: "computer"})).toEqual(["X"]);
  });

  it("should make an AJAX request for a computer url", function() {
    spyOn($, "ajax");
    parse({board:"-", next_move: "computer"});
    expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/best_move?board=-");
  });
});
