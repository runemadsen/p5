# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'p5/version'

Gem::Specification.new do |gem|
  gem.name          = "p5"
  gem.version       = P5::VERSION
  gem.authors       = ["Rune Skjoldborg Madsen"]
  gem.email         = ["rune@runemadsen.com"]
  gem.description   = %q{P5 is a ruby gem that makes it easy to run Processing sketches on a headless web server.}
  gem.summary       = %q{Run Headless Processing from Ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "headless", "1.0.1"
  gem.add_development_dependency "test-unit"
  gem.add_development_dependency "turn"
  gem.add_development_dependency "minitest"
end
