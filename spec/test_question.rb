require 'question'
require 'qt'

class TestQuestion < Dan::Question

  def initialize(answers)
    super()
    @answers = answers
  end

  def exec
  end

  def []=(key, value)
    @answers[key] = value
  end
  
  def clickedButton 
    @answers[text] ? @yes : @no 
  end
end
