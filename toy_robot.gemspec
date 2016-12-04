# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "toy_robot/version"

Gem::Specification.new do |spec|
  spec.name                  = "another_toy_robot"
  spec.version               = ToyRobot::VERSION
  spec.date                  = "2016-12-01"
  spec.authors               = "Sheldon J. Johnson"
  spec.email                 = "sheldon.j.johnson@outlook.com"
  spec.homepage              = "https://github.com/drzel/toy_robot"
  spec.summary               = "Another toy robot demonstration app"
  spec.required_ruby_version = ">= 2.3"
  spec.license               = "MIT"

  spec.description = "The application is a simulation of a toy robot moving "  \
    "on a square tabletop.  It is an example of a well tested, object "        \
    "oriented design, employing the command design pattern."

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = "bin"
  spec.executables << "toy_robot"

  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rake", "~> 11.3"
  spec.add_development_dependency "factory_girl", "~> 4.0"
  spec.add_development_dependency "simplecov", "~> 0.12"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
end
