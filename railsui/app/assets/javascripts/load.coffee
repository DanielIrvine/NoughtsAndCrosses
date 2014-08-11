#= require 'game'

$ ->
  new Game($(document.body), window.location.href).start()
