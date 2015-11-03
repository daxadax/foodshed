require 'sinatra'
require 'bundler'
Bundler.require

require 'rack/test'
Dir.glob('./entities/*.rb') { |f| require f }
Dir.glob('./gateways/*.rb') { |f| require f }
Dir.glob('./presenters/*.rb') { |f| require f }
require './foodshed'
require 'minitest/autorun'

class FoodshedSpec < Minitest::Spec
  def assert_failure(&block)
    assert_raises(ArgumentError, &block)
  end
end
