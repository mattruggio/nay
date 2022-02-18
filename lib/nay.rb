# frozen_string_literal: true

require 'stringio'
require 'strscan'

require_relative 'nay/evaluator'
require_relative 'nay/lexer'

# Top-level API
module Nay
  class << self
    def evaluate(string = '', input = {})
      lexer     = Lexer.new(string)
      evaluator = Evaluator.new(lexer)

      evaluator.evaluate(input)
    end
  end
end
