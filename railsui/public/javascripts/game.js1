var NoughtsAndCrosses = {};

NoughtsAndCrosses.Game = function() {

  var parse = function(json)
  {
    var board = convertBoard(json);
    for(var i = 0; i < board.length; ++i) { 
      setSquareContent(board[i], i, json);
    }

    if(shouldPlayNextComputerMove(json))
    {
      setTimeout(function(){
        makeMove('');
      }, 1000);
    }
    setStatusText(json.status_text);
  };

  var setSquareContent = function(sq, i, json)
  {
    var sqid = "#sq-" + i;
    var elem = $(sqid).find('a');
    elem.empty();
    elem.off('click');
    if (shouldDisplayLink(sq, json)) {
      elem.on('click', function(){makeMove(i);}); 
    }
    elem.append(sq.text);
  };

  var shouldPlayNextComputerMove = function(json)
  {
    return !json.finished && json.next_move == "computer";
  };
  
  var shouldDisplayLink = function(sq, json) 
  {
    return sq.link && !json.finished && json.next_move !== "computer";
  };

  var setStatusText = function(text)
  {
    $('#status').empty();
    $('#status').append(text);
  };

  var makeMove = function(sq)
  {
    var url = oPublic.getCurrentUrl();
    var newUrl = urlRoot(url) + "/make_move?sq=" + sq;
    $.ajax({url: newUrl, success: parse});
  };

  var convertBoard = function(json)
  {
    var board = [];
    for(var i = 0; i < json.board.length; ++i)
    {
      var sq = json.board[i];
      board[i] = sq == '-' ? {link: true} : {text: sq};
    }
    return board;
  };

  var start = function()
  {
    var url = oPublic.getCurrentUrl();
    var argsLocation = url.indexOf('?');
    var args = url.slice(argsLocation + 1);
    var newUrl = urlRoot(url) + "/get_board?" + args;
    $.ajax({url: newUrl, success: parse});
  };

  var getCurrentUrl = function() {
    return window.location.href;
  };

  var urlRoot = function(url)
  {
    var rootLocation = url.lastIndexOf('/');
    return rootLocation === -1 ? '' : url.slice(0, rootLocation);
  };

  var oPublic =
  {
    convertBoard: convertBoard,
    parse: parse,
    makeMove: makeMove,
    start: start,
    getCurrentUrl: getCurrentUrl
  };

  return oPublic;

}();

$(document).ready(function() {
  NoughtsAndCrosses.Game.start();
});
