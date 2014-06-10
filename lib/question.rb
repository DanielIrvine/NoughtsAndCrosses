require 'qt'

module Dan
class Question < Qt::MessageBox

  def initialize
    super(nil)
    setIcon(Qt::MessageBox::Question)
    setWindowTitle('Noughts and Crosses')
    addButton(Qt::MessageBox::Yes)
    addButton(Qt::MessageBox::No)
    setDefaultButton(Qt::MessageBox::No)
  end

  def ask(question)
    setText(question)
    show
    clickedButton == Qt::MessageBox::Yes
  end
end
end
