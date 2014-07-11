describe("game", function(){

  it("converts an empty square to a link", function() {
    expect(convertBoard({board:"-"})).toEqual(
      [{link:true}])
  );

  it("converts all squares", function() {
    expect(convertBoard({board:"---"})).toEqual(
      [{link:true},
      {link:true},
      {link:true}])
  });

  it("displays X", function() {
    expect(convertBoard({board:"X"})).toEqual([{text:"X"}])
  });

  it("displays O", function() {
    expect(convertBoard({board: "O"})).toEqual([{text:"O"}]);
  });

  it("makes an AJAX request for a computer player", function() {
    var bestMoveCall = null;
    spyOn($, "ajax").andCallFake(function(opts){
      if (!bestMoveCall) bestMoveCall = opts.url;
    });
    parse({board:"-", next_move: "computer", x: "ComputerPlayer", o: "HumanPlayer" });
    expect(bestMoveCall).toEqual("/make_move?sq=&board=-&x=ComputerPlayer&o=HumanPlayer");
  });

  it("does not make an AJAX request for a human player", function() {
    spyOn($, "ajax");
    parse({board:"-"});
    expect($.ajax.callCount).toEqual(0);
  });

  it("makes an AJAX request when a square is clicked", function() {
    spyOn($, "ajax");
    make_move(1, "---", "HumanPlayer", "HumanPlayer");
    expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/make_move?sq=1&board=---&x=HumanPlayer&o=HumanPlayer");
  });

  it("calls parse function when make_move returns", function() {
    spyOn($, "ajax").andCallFake(function(opts){
      opts.success();
    });
    var callback = jasmine.createSpy();
    make_move(0, "---", "HumanPlayer", "HumanPlayer", callback);
    expect(callback).toHaveBeenCalled();
  });

  it("sets square content when parsing json", function() {
    setFixtures('<div id="sq-0"><a/></div>'+
                '<div id="sq-1"><a/></div>'+
                '<div id="sq-2"><a/></div>');
    parse({board:"X-O"});
    expect($('#sq-0')).toHaveText("X");
    expect($('#sq-1').find('a')).toBeEmpty();
    expect($('#sq-2')).toHaveText("O");
  });

  it("sets square link when parsing json", function() {
    spyOn($, "ajax");
    setFixtures('<div id="sq-0"><a/></div>');
    parse({board:"-"});
    $('#sq-0').find('a').trigger('click');
    expect($.ajax.callCount).toEqual(1);
  });

  it("unsets click handler", function() {
    spyOn($, "ajax");
    setFixtures('<div id="sq-0"><a/></div>');
    parse({board:"-"});
    parse({board:"X"});
    $('#sq-0').find('a').trigger('click');
    expect($.ajax.callCount).toEqual(0);
  });

  it("displays status text", function() {
    setFixtures('<div id="status" />');
    parse({board:"XXOOOXXOX", status_text: "It's a draw!"});
    expect($('#status')).toHaveText("It's a draw!");
  });

  it("has no links if game is finished", function() {
    spyOn($, "ajax");
    setFixtures('<div id="sq-0"><a/></div>');
    parse({board:"-", finished: true});
    $('#sq-0').find('a').trigger('click');
    expect($.ajax.callCount).toEqual(0);
  });
});
