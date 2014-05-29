$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

RSpec.configure do |conf|
  conf.order = 'random'
end

