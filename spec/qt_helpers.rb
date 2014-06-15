RSpec.shared_context :qt do

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end
  
  def find_widget(parent, name)
    parent.children.find{ |w| w.object_name==name }
  end
    
  RSpec::Matchers.define :have_label_with_text do |expected|
    match do |widget|
      widget.children.any? do |child|
        child.kind_of?(Qt::Label) && child.text==expected
      end
      false
    end
  end

  RSpec::Matchers.define :have_labels_with_text do |*ary|
    match do |widget|
      widget.children.each do |child|
        if child.kind_of?(Qt::Label) && ary.include?(child.text)
          ary.delete(child.text)
        end
      end
      ary.length == 0
    end
  end
end
