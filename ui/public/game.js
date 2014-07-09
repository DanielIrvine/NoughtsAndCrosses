function parse(json)
{
  convertBoard(json).forEach(function(sq, i) {
    var sqid = "#sq-" + i;
    var elem = $(sqid).find('a');
    elem.empty();
    if (sq.link) { 
      elem.on('click', function(){make_move(i, json.board)}); 
    }
    else {
      elem.off('click');
    }
    elem.append(sq.text);
  });
  // TODO: set status text
  if(json.next_move == "computer")
  {
    get_and_play_computer_move("-");
  }
}

function get_and_play_computer_move(board, auto_play_callback)
{
  if(typeof auto_play_callback === "undefined") 
  {
    auto_play_callback = function(result) { play_computer_move(result) };
  }
    $.ajax({url: "/best_move?board=" + board,
            success: auto_play_callback });
}

function play_computer_move(move) {
    // TODO: call make_move(result, board) after time period
  make_move(move.best_move, move.board);
}

function convertToLink(sq, board)
{
  return "make_move(" + sq + "'" + board + "');";
}

function make_move(sq, board, parse_callback)
{
  if (typeof parse_callback === "undefined") 
  {
    parse_callback = function(result) { parse(result); };
  }
  $.ajax({url: "/make_move?sq=" + sq + "&board=" + board,
          success: parse_callback});
}

function convertBoard(json)
{
  var createLinks = json.next_move != "computer";
  return json.board.split('').map(function(sq) {
    return createSquare(sq, createLinks);
  });
}

function createSquare(sq, createLinks)
{
  if(sq == '-') {
    return createLinks ? {text: "", link: true} : {text: ""};
  }
  else {
    return {text: sq};
  }
}


