# frozen_string_literal: true

require 'stringio'
require 'strscan'

require_relative 'nay/template'

# Top-level API
module Nay
  class << self
    def evaluate(object, parameters = {})
      Template.new(object).evaluate(parameters)
    end
  end
end
