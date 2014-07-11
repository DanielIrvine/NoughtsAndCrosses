var NoughtsAndCrosses = NoughtsAndCrosses || {};

NoughtsAndCrosses.Game = function() {

  var parse = function(json)
  {
    convertBoard(json).forEach(function(sq, i) {
      setSquareContent(sq, i, json);
    });

    if(json.next_move == "computer")
    {
      makeMove('', json.board, json.x, json.o)
    }
    setStatusText(json.status_text);
  }

  var setSquareContent = function(sq, i, json)
  {
    var sqid = "#sq-" + i;
    var elem = $(sqid).find('a');
    elem.empty();
    elem.off('click');
    if (shouldDisplayLink(sq, json)) {
      elem.on('click', function(){makeMove(i, json.board, json.x, json.o)}); 
    }
    elem.append(sq.text);
  }

  var shouldDisplayLink = function(sq, json) 
  {
    return sq.link && !json.finished && json.next_move !== "computer";
  }

  var setStatusText = function(text)
  {
    $('#status').empty();
    $('#status').append(text);
  }

  var makeMove = function(sq, board, x, o)
  {
    $.ajax({url: "/make_move?sq=" + sq + "&board=" + board + "&x=" + x + "&o=" + o,
      success: parse});
  }

  var convertBoard = function(json)
  {
    return json.board.split('').map(function(sq) {
      return sq == '-' ? {link: true} : {text: sq};
    });
  }

  var start = function(context)
  {
    var argsLocation = context.location.href.indexOf('?');
    var args = context.location.href.slice(argsLocation + 1);
    $.ajax({url: "/get_board?" + args,
            success: parse});
  };

  var oPublic =
  {
    convertBoard: convertBoard,
    parse: parse,
    makeMove: makeMove,
    start: start
  };

  return oPublic;

}();

$(document).ready(function() {
  NoughtsAndCrosses.Game.start(window);
});
