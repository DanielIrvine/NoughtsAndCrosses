function parse(json)
{
  convertBoard(json).forEach(function(sq, i) {
    set_square_content(sq, i, json);
  });

  if (json.gameOver) {
  if(json.next_move == "computer")
  {
    make_move('', json.board, json.x, json.o)
  }
  set_status_text(json.status_text);
}

function set_square_content(sq, i, json)
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

function should_display_link(sq, json) 
{
  return sq.link && !json.finished && json.next_move !== "computer";
}

function set_status_text(text)
{
  $('#status').empty();
  $('#status').append(text);
}

function make_move(sq, board, x, o, parse_callback)
{
  if (typeof parse_callback === "undefined") 
  {
    parse_callback = function(result) { parse(result); };
  }
  $.ajax({url: "/make_move?sq=" + sq + "&board=" + board + "&x=" + x + "&o=" + o,
          success: parse_callback});
}

function convertBoard(json)
{
  return json.board.split('').map(function(sq) {
    return sq == '-' ? {link: true} : {text: sq};
  });
}

