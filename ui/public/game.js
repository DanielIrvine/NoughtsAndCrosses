$.ajaxSetup( { cache: false });

function onload {
  var params = location.search.substr(1).split('game/');
  var link = 'state/' + params[1];
  moveToNextState(link);
}

function parse(state) {
  parseBoard(state.board);
  parseStatus(state.status);
  parseNextMove(state.next_move);
}

function parseBoard(board, size)
{
  for( int i = 0; i < size; ++i ) {
    $('#board > tbody.last').append('<tr>');
    
    for( int j = 0; j < size; ++j) {
      $('#board > tbody.last').append('<td>');
      var sq = board[i*size + j]
      if(sq.move_link == undefined) {
        insertText(sq)
      }
      else
      {
        insertLink(sq)
      }
      $('#board > tbody.last').append('</td>');
    }

    $('#board > tbody.last').append('</tr>');
  }
}

function insertText(sq)
{
  $('#board > tbody.last').append(sq);
}

function insertLink(sq)
{
  $('#board > tbody.last').append('<a href="" onclick="moveToNextState(' + sq.link + ');" />');
}

function parseStatus(message)
{
  $('#state').replace('<p class="status">' + message + '</p>');
}

function parseNextMove(nextMove)
{
  if( nextMove != undefined ) {
    // TODO
  }
}

function moveToNextState(link)
{
  $.getJSON(link, nil, parse)
}
