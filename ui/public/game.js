var NoughtsAndCrosses = {};

NoughtsAndCrosses.Game = function () {

  var url = '';

  var parse = function (json){
    var board = convertBoard(json);
    var i;
    for(i = 0; i < board.length; ++i) { 
      setSquareContent(board[i], i, json);
    }

    if(shouldPlayNextComputerMove(json))
    {
      setTimeout(function(){
        makeMove('', json.board, json.x, json.o);
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
      elem.on('click', function(){makeMove(i, json.board, json.x, json.o);}); 
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

  var makeMove = function(sq, board, x, o)
  {
    var newUrl = urlRoot() + "/make_move?sq=" + sq + "&board=" + board + "&x=" + x + "&o=" + o;
    $.ajax({url: newUrl,
      success: parse});
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

  var start = function(root_url)
  {
    url = root_url;
    var argsLocation = url.indexOf('?');
    var args = url.slice(argsLocation + 1);
    var newUrl = urlRoot() + "/get_board?" + args;
    $.ajax({url: newUrl, success: parse});
  };

  var urlRoot = function() {
    var rootLocation = url.lastIndexOf('/');
    return rootLocation === -1 ? '' : url.slice(0, rootLocation);
  };

  return {
    convertBoard: convertBoard,
    parse: parse,
    makeMove: makeMove,
    start: start,
    set_url: function(new_url) {
      url = new_url;
    }
  };

}();

$(document).ready(function() {
  NoughtsAndCrosses.Game.start(window.location.href);
});
