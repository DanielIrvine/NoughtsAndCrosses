require 'game_board_widget'
require 'gui_display'

app = Qt::Application.new(ARGV)
widget = GameBoardWidget.new
app.mainWidget = widget
gui_display = GUIDisplay.new(widget)

game = GameBuilder.new(gui_display).build
gui_display.on_play = Proc.new { game.play_all! }

gui_display.show
app.exec

