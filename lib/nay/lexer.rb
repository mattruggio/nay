# frozen_string_literal: true

require_relative 'state'
require_relative 'token'

module Nay
  # Read in a string and generate Token instances.
  class Lexer
    # Stack States
    EXPRESSION              = :expression
    EXPRESSION_LITERAL      = :expression_literal

    # Token Types
    CLOSE_EXPRESSION        = :close_expression
    CONTENT                 = :content
    END_EXPRESSION_LITERAL  = :end_expression_literal
    IDENTIFIER              = :identifier
    IGNORE                  = :ignore
    OPEN_EXPRESSION         = :open_expression
    OPEN_EXPRESSION_LITERAL = :open_expression_literal

    attr_reader :scanner, :state

    def initialize(string)
      @scanner = StringScanner.new(string)
      @state   = State.new
    end

    def rest
      [].tap do |tokens|
        while (token = next_token)
          tokens << token
        end
      end
    end

    def next_token
      return nil if scanner.eos?

      case state.current
      when State::DEFAULT
        default
      when EXPRESSION
        expression
      when EXPRESSION_LITERAL
        expression_literal
      end
    end

    private

    # rubocop:disable Metrics/AbcSize
    def default
      token = nil

      if scanner.scan(/<</)
        state.push(EXPRESSION)
        token = Token.new(OPEN_EXPRESSION, scanner.matched)
      elsif scanner.scan_until(/.*?(?=<<)/m)
        token = Token.new(CONTENT, scanner.matched)
      else
        token = Token.new(CONTENT, scanner.rest)
        scanner.terminate
      end

      token
    end

    def expression
      token = nil

      if scanner.scan(/\s+/) || scanner.scan(/\./)
        token = Token.new(IGNORE, scanner.matched)
      elsif scanner.scan(/>>/)
        token = Token.new(CLOSE_EXPRESSION, scanner.matched)
        state.pop
      elsif scanner.scan(/"/)
        state.push(EXPRESSION_LITERAL)
        token = Token.new(OPEN_EXPRESSION_LITERAL, scanner.matched)
      elsif scanner.scan_until(/[a-zA-Z0-9_-]*?(?=\s|\.|>>)/m)
        token = Token.new(IDENTIFIER, scanner.matched)
      else
        scanner.terminate
      end

      token
    end
    # rubocop:enable Metrics/AbcSize

    def expression_literal
      token = nil

      if scanner.scan(/"/)
        state.pop
        token = Token.new(:end_expression_literal, scanner.matched)
      elsif scanner.scan_until(/.*?(?=")/m)
        token = Token.new(IDENTIFIER, scanner.matched)
      else
        scanner.terminate
      end

      token
    end
  end
end
