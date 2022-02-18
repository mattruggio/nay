# frozen_string_literal: true

module Nay
  # Knows how to take a stream of lexically analyzed tokens along with a parameters hash and
  # evaluate interpolated key paths.
  class Evaluator
    attr_reader :lexer

    def initialize(lexer)
      @lexer = lexer
    end

    def evaluate(parameters = {})
      io      = StringIO.new
      pointer = parameters

      while (token = lexer.next_token)
        case token.type
        when Lexer::CONTENT
          io << token.literal
        when Lexer::OPEN_EXPRESSION
          pointer = parameters
        when Lexer::IDENTIFIER
          pointer = traverse(pointer, token.literal)
        when Lexer::CLOSE_EXPRESSION
          io << pointer.to_s
        end
      end

      io.string
    end

    private

    def traverse(parameters, value)
      parameters[value] if parameters.respond_to?(:[])
    end
  end
end
