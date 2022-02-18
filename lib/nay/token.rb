# frozen_string_literal: true

module Nay
  # Describes the output of the Lexer.
  class Token
    attr_reader :type, :literal

    def initialize(type, literal = nil)
      @type    = type.to_sym
      @literal = literal

      freeze
    end

    def to_s
      "['#{type}', '#{literal}']"
    end

    def ==(other)
      other.type == type && other.literal == literal
    end
    alias eql? ==
  end
end
