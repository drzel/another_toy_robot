source "https://rubygems.org"

gem "pry"
gem "rspec"
gem "factory_girl", "~> 4.0"

# guard dependency, not yet compatible with 0.19.0
# https://github.com/guard/guard/issues/859
gem 'thor', '~> 0.18.0' 

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'simplecov', require: false
  gem "codeclimate-test-reporter", "~> 1.0.0"
end

# Specify your gem's dependencies in toy_robot.gemspec
gemspec
