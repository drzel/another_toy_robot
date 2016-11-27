# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toy_robot/version'

Gem::Specification.new do |spec|
  spec.name          = "another_toy_robot"
  spec.version       = ToyRobot::VERSION
  spec.date          = "2016-11-27"
  spec.authors       = ["Sheldon J. Johnson"]
  spec.email         = ["sheldon.j.johnson@outlook.com"]

  spec.summary       = %q{Another toy robot demonstration app}
  spec.description   = %q{The application is a simulation of a toy robot moving on a square tabletop.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
