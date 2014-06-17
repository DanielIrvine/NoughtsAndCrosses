RSpec.shared_context :qt do

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end
  
  def find_widget(parent, name)
    parent.find_child(Qt::Widget, name)
  end
    
  RSpec::Matchers.define :have_label_with_text do |expected|
    match do |widget|
      widget.find_children(Qt::Label).any? do |child|
        child.text==expected
      end
    end
  end

  RSpec::Matchers.define :have_labels_with_text do |*ary|
    match do |widget|
      widget.find_children(Qt::Label).each do |child|
        if ary.include?(child.text)
          ary.delete(child.text)
        end
      end
      ary.length == 0
    end
  end

  RSpec::Matchers.define :have_radio_button do |expected|
    match do |widget|
      widget.find_children(Qt::RadioButton).any? do |child|
        child.object_name==expected
      end
    end
  end

  RSpec::Matchers.define :have_button_with_text do |expected|
    match do |widget|
      widget.find_children(Qt::PushButton).any? do |child|
        child.text == expected
      end
    end
  end

  RSpec::Matchers.define :have_child_of_type do |expected|
    match do |widget|
      widget.find_child(expected)
    end
  end
end
