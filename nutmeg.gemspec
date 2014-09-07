# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nutmeg/version'

Gem::Specification.new do |spec|
  spec.name          = "nutmeg"
  spec.version       = Nutmeg::VERSION
  spec.authors       = ["Dennis van der Vliet"]
  spec.email         = ["dennis.vandervliet@gmail.com"]
  spec.description   = %q{Make creating trees in rails easier and close to fun}
  spec.summary       = %q{Easy trees in rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rubytree"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
