function convertBoard(json)
{
  var createLinks = json.next_move != "computer";
  return json.board.split('').map(function(sq, i) {
    return createSquare(sq, i, json.board, createLinks);
  });
}

function createSquare(sq, i, board, createLinks)
{
  if(sq == '-') {
    return createLinks ? createLink(i, board) : "";
  }
  else {
    return sq;
  }
}

function createLink(sq, board)
{
  return "make_move?sq=" + sq + "&board=" + board;
}
