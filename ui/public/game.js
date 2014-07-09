function parse(json)
{
}

function parse(json, callback)
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
    $.ajax({url: "/best_move?board=-",
            success: callback });
  }
}

function convertToLink(sq, board)
{
  return "make_move(" + sq + "'" + board + "');";
}

function make_move(sq, board)
{
  $.ajax({url: "/make_move?sq=" + sq + "&board=" + board,
          success: function(response) 
  {
    parse(response, function(response) {
      make_move(response.best_move, response.board);
    });
  } });
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


