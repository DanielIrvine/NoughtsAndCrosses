class SimplifiedStringIO

  def initialize(input_str = '')
    @reader = StringIO.new(input_str)
    @writer = StringIO.new
  end
  
  def puts(str)
    @writer.puts(str)
  end

  def read
    @writer.read
  end

  def string
    @writer.string
  end

  def gets
    @reader.gets
  end
end
