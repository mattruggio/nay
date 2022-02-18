# frozen_string_literal: true

require 'pry'
require 'yaml'

unless ENV['DISABLE_SIMPLECOV'] == 'true'
  require 'simplecov'
  require 'simplecov-console'

  SimpleCov.formatter = SimpleCov::Formatter::Console
  SimpleCov.start do
    add_filter %r{\A/spec/}
  end
end

def read_yaml_fixture(*path)
  YAML.safe_load(File.read(File.join('spec', 'fixtures', *path)))
end

require 'rspec/expectations'
require './lib/nay'
