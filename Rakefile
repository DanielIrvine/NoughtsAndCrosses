require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = '**/spec/**/*_spec.rb'
  t.verbose = false
end

task :default => :spec
