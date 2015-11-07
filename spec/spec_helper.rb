require 'sinatra'
require 'bundler'
Bundler.require

ENV['develop'] = '1'

require 'rack/test'
require './app_config'
Dir.glob('./entities/*.rb') { |f| require f }
Dir.glob('./gateways/*.rb') { |f| require f }
Dir.glob('./gateways/backends/*.rb') { |f| require f }
Dir.glob('./presenters/*.rb') { |f| require f }
require './foodshed'
require 'minitest/autorun'

class FoodshedSpec < Minitest::Spec
  before { Config.reset_memory_backend }

  def assert_failure(&block)
    assert_raises(ArgumentError, &block)
  end
end
