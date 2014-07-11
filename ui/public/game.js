var NoughtsAndCrosses = NoughtsAndCrosses || {};

NoughtsAndCrosses.Game = function() {

  var parse = function(json)
  {
    convertBoard(json).forEach(function(sq, i) {
      set_square_content(sq, i, json);
    });

    if(json.next_move == "computer")
    {
      make_move('', json.board, json.x, json.o)
    }
    set_status_text(json.status_text);
  }

  var set_square_content = function(sq, i, json)
  {
    var sqid = "#sq-" + i;
    var elem = $(sqid).find('a');
    elem.empty();
    elem.off('click');
    if (should_display_link(sq, json)) {
      elem.on('click', function(){make_move(i, json.board, json.x, json.o)}); 
    }
    elem.append(sq.text);
  }

  var should_display_link = function(sq, json) 
  {
    return sq.link && !json.finished && json.next_move !== "computer";
  }

  var set_status_text = function(text)
  {
    $('#status').empty();
    $('#status').append(text);
  }

  var make_move = function(sq, board, x, o, parse_callback)
  {
    if (typeof parse_callback === "undefined") 
    {
      parse_callback = function(result) { parse(result); };
    }
    $.ajax({url: "/make_move?sq=" + sq + "&board=" + board + "&x=" + x + "&o=" + o,
      success: parse_callback});
  }

  var convertBoard = function(json)
  {
    return json.board.split('').map(function(sq) {
      return sq == '-' ? {link: true} : {text: sq};
    });
  }

  var oPublic =
  {
    convertBoard: convertBoard,
    parse: parse,
    make_move: make_move
  };

  return oPublic;

}();
