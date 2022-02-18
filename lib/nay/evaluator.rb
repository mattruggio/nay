# frozen_string_literal: true

module Nay
  # Knows how to take a stream of lexically analyzed tokens along with an input hash and
  # evaluate interpolated key paths.
  class Evaluator
    attr_reader :lexer

    def initialize(lexer)
      @lexer = lexer
    end

    def evaluate(input = {})
      io      = StringIO.new
      pointer = input

      while (token = lexer.next_token)
        case token.type
        when Lexer::CONTENT
          io << token.literal
        when Lexer::OPEN_EXPRESSION
          pointer = input
        when Lexer::IDENTIFIER
          pointer = traverse(pointer, token.literal)
        when Lexer::CLOSE_EXPRESSION
          io << pointer.to_s
        end
      end

      io.string
    end

    private

    def traverse(input, value)
      input[value] if input.respond_to?(:[])
    end
  end
end
