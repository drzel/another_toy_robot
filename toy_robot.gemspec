# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toy_robot/version'

Gem::Specification.new do |spec|
  spec.name          = "another_toy_robot"
  spec.version       = ToyRobot::VERSION
  spec.date          = "2016-11-27"
  spec.authors       = "Sheldon J. Johnson"
  spec.email         = "sheldon.j.johnson@outlook.com"
  spec.homepage      = "https://github.com/drzel/toy_robot"
  spec.summary       = "Another toy robot demonstration app"
  spec.description   = "The application is a simulation of a toy robot "      \
    "moving on a square tabletop. It is an example of a well tested, object " \
    "oriented design, employing the command design pattern."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables  << "toy_robot"
end
