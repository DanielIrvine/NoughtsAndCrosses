function convert_board(json)
{
  var squares = json.board.split('');
  var result = [];
  for(var i = 0; i < squares.length; ++i)
  {
    if(squares[i] == '-') {
      result[i] = "make_move?sq=" + i + "&board=" + json.board;
    } else {
      result[i] = squares[i];
    }
  }
  return result;
}
