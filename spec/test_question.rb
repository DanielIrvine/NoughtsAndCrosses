require 'question'

class TestQuestion < Dan::Question

  def initialize(answers)
    super()
    @answers = answers
  end

  def ask(text)
    @answers[text]
  end
end
