# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'another_toy_robot/version'

Gem::Specification.new do |spec|
  spec.name                  = 'another_toy_robot'
  spec.version               = AnotherToyRobot::VERSION
  spec.date                  = '2016-12-07'
  spec.authors               = 'Sheldon J. Johnson'
  spec.email                 = 'sheldon.j.johnson@outlook.com'
  spec.homepage              = 'https://github.com/drzel/another_toy_robot'
  spec.summary               = 'Another toy robot demonstration app'
  spec.required_ruby_version = '>= 3.4'
  spec.license               = 'MIT'

  spec.description = 'The application is a simulation of a toy robot moving '  \
    'on a square tabletop.  It is an example of a well tested, object '        \
    'oriented design, employing the command design pattern.'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'bin'
  spec.executables << 'another_toy_robot'

  spec.add_development_dependency 'factory_bot', '~> 6.5'
  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'simplecov', '~> 0.22'
end
