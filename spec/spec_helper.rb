require 'sinatra'
require 'bundler'
Bundler.require

require 'rack/test'
Dir.glob('./presenters/*.rb') { |f| require f }
require './foodshed'
require 'minitest/autorun'

class FoodshedSpec < Minitest::Spec

end
