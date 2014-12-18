# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'falling_hats/version'

Gem::Specification.new do |spec|
  spec.name          = "falling_hats"
  spec.version       = FallingHats::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{A game by Gosu (http://www.libgosu.org/).}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/myokoym/falling_hats"
  spec.license       = "zlib"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("gosu")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
end
