require 'rubygems'
require 'bundler/setup'
require 'sass/plugin/rack'
require 'sass'
require 'json'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

Bundler.require

require './foodshed'
Dir.glob('./presenters/*.rb') { |f| require f }

run Foodshed
