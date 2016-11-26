require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "factory_girl"
require "support/factory_girl"
require "pry"
require "./lib/toy_robot/version"
require "./lib/toy_robot/client"
require "./lib/toy_robot/robot"
require "./lib/toy_robot/arena"
require "./lib/toy_robot/command"
require "./lib/toy_robot/position"
