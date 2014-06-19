require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
end

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'bundler/setup'

RSpec.configure do |conf|
  conf.order = 'random'
end

