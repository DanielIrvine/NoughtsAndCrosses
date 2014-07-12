var NoughtsAndCrosses = NoughtsAndCrosses || {};

NoughtsAndCrosses.Game = function() {

  var parse = function(json)
  {
    var board = convertBoard(json);
    for(var i = 0; i < board.length; ++i) { 
      setSquareContent(board[i], i, json);
    };

    if(shouldPlayNextComputerMove(json))
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

  var shouldPlayNextComputerMove = function(json)
  {
    return !json.finished && json.next_move == "computer";
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
    var board = [];
    for(var i = 0; i < json.board.length; ++i)
    {
      var sq = json.board[i];
      board[i] = sq == '-' ? {link: true} : {text: sq};
    }
    return board;
  }

  var start = function(context)
  {
    var argsLocation = context.location.href.indexOf('?');
    var args = context.location.href.slice(argsLocation + 1);
    $.ajax({url: "/get_board?" + args, success: parse});
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
