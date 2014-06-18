RSpec.shared_context :qt do

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end
  
  def find_widget(parent, name)
    parent.find_child(Qt::Widget, name)
  end
    
  RSpec::Matchers.define :have_label_with_text do |expected|
    match do |widget|
      children_of_type(widget, Qt::Label).any? do |child|
        child.text==expected && !child.hidden?
      end
    end
  end

  RSpec::Matchers.define :have_labels_with_text do |*ary|
    match do |widget|
      children_of_type(widget, Qt::Label).each do |child|
        if ary.include?(child.text) && !child.hidden?
          ary.delete(child.text)
        end
      end
      ary.length == 0
    end
  end

  RSpec::Matchers.define :have_radio_button do |expected|
    match do |widget|
      children_of_type(widget, Qt::RadioButton).any? do |child|
        child.object_name==expected
      end
    end
  end

  RSpec::Matchers.define :have_button_with_text do |expected|
    match do |widget|
      children_of_type(widget, Qt::PushButton).any? do |child|
        child.text == expected
      end
    end
  end

  RSpec::Matchers.define :have_child_of_type do |expected|
    match do |widget|
      children_of_type(widget, expected).any?
    end
  end

  RSpec::Matchers.define :have_multiple_children_of_type do |expected|
    match do |widget|
     children_of_type(widget, expected).length > 1
    end
  end

  def children_of_type(widget, type)
    widget.find_children(type).find_all { |c| c.kind_of?(type) }
  end
end
