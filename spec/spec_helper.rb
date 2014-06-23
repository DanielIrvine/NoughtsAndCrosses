
dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir + '/../core/spec'
$LOAD_PATH.unshift dir + '/../ui/spec'

require_relative '../core/spec/spec_helper.rb'
require_relative '../ui/spec/spec_helper.rb'
