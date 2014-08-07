/*jslint indent: 2, browser: true */
/*global $ */
var NoughtsAndCrosses = {};

NoughtsAndCrosses.Game = (function () {

  "use strict";

  var convertBoard,
    makeMove,
    parse,
    setSquareContent,
    setStatusText,
    shouldDisplayLink,
    shouldPlayNextComputerMove,
    start,
    url = '',
    urlRoot;


  function urlRoot() {
    var rootLocation = url.lastIndexOf('/');
    return rootLocation === -1 ? '' : url.slice(0, rootLocation);
  };

  function makeMove(sq, board, x, o) {
    var newUrl = urlRoot() + "/make_move?sq=" + sq + "&board=" + board + "&x=" + x + "&o=" + o;
    $.ajax({url: newUrl,
      success: parse});
  };

  function shouldPlayNextComputerMove(json) {
    return !json.finished && json.next_move === "computer";
  };

  function shouldDisplayLink(sq, json) {
    return sq.link && !json.finished && json.next_move !== "computer";
  };

  function setSquareContent(sq, i, json) {
    var sqid = "#sq-" + i,
        elem = $(sqid).find('a');
    elem.empty();
    elem.off('click');
    if (shouldDisplayLink(sq, json)) {
      elem.on('click', function () {makeMove(i, json.board, json.x, json.o); });
    }
    elem.append(sq.text);
  };

  function setStatusText(text) {
    $('#status').empty();
    $('#status').append(text);
  };

  function convertBoard(json) {
    var i = 0, board = [], sq;
    for (i = 0; i < json.board.length; i += 1) {
      sq = json.board[i];
      board[i] = sq === '-' ? {link: true} : {text: sq};
    }
    return board;
  };

  function start(root_url) {
    url = root_url;
    var argsLocation = url.indexOf('?'),
        args = url.slice(argsLocation + 1),
        newUrl = urlRoot() + "/get_board?" + args;
    $.ajax({url: newUrl, success: parse});
  };

  function parse(json) {
    var board = convertBoard(json), i;
    for (i = 0; i < board.length; i += 1) {
      setSquareContent(board[i], i, json);
    }

    if (shouldPlayNextComputerMove(json)) {
      setTimeout(function () {
        makeMove('', json.board, json.x, json.o);
      }, 1000);
    }
    setStatusText(json.status_text);
    };

  return {
    convertBoard: convertBoard,
    parse: parse,
    makeMove: makeMove,
    start: start
  };

}());

$(document).ready(function () {
  "use strict";
  NoughtsAndCrosses.Game.start(window.location.href);
});
