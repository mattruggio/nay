# frozen_string_literal: true

require_relative 'evaluator'
require_relative 'lexer'

module Nay
  # Built on top of the string-based Lexer/Evaluator but instead of only working for a string,
  # this will recursively evaluate all strings within an object.  Heuristics:
  #    - Hashes will have their keys and parameters traversed
  #    - Arrays will have their entries traversed
  #    - Strings evaluate using Lexer
  #    - All other types will simply return themselves (not be traversed or use the Lexer)
  class Template
    attr_reader :object

    def initialize(object)
      @object = object

      freeze
    end

    def evaluate(parameters = {})
      recursive_evaluate(object, parameters)
    end

    private

    def recursive_evaluate(expression, parameters)
      case expression
      when Array
        expression.map { |o| recursive_evaluate(o, parameters) }
      when Hash
        expression.to_h do |k, v|
          [recursive_evaluate(k, parameters), recursive_evaluate(v, parameters)]
        end
      when String
        Evaluator.new(Lexer.new(expression)).evaluate(parameters)
      else
        expression
      end
    end
  end
end
