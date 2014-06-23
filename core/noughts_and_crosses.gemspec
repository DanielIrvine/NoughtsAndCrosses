# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'noughts_and_crosses/version'

Gem::Specification.new do |spec|
  spec.name          = "noughts_and_crosses"
  spec.version       = NoughtsAndCrosses::VERSION
  spec.authors       = ["Daniel Irvine"]
  spec.email         = ["dirvine@8thlight.com"]
  spec.summary       = %q{Noughts and crosses API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
