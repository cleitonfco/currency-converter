#require 'rubygems'
#require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib')) unless
  $:.include?(File.join(File.dirname(__FILE__), '..', 'lib')) || $:.include?(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'currency_converter'
