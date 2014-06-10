require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
end

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

RSpec.configure do |conf|
  conf.order = 'random'
end
