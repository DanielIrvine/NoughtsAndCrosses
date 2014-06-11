require 'question'
require 'qt'

class TestQuestion < Dan::Question

  def initialize(answers)
    super()
    @answers = answers
  end

  def show
  end

  def []=(key, value)
    @answers[key] = value
  end
  
  def clickedButton
    @answers[text] ? Qt::MessageBox::Yes : Qt::MessageBox::No
  end
end
