require 'qt'

module Dan
class Question < Qt::MessageBox

  def initialize
    super(nil)
    setIcon(Qt::MessageBox::Question)
    setWindowTitle('Noughts and Crosses')
    @yes = addButton(Qt::MessageBox::Yes)
    @no = addButton(Qt::MessageBox::No)
    setDefaultButton(Qt::MessageBox::No)
    setWindowModality(Qt::ApplicationModal)
  end

  def ask(question)
    setText(question)
    self.exec()
    buttonRole(clickedButton) == Qt::MessageBox::YesRole 
  end

end
end

