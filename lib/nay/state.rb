# frozen_string_literal: true

module Nay
  # Basic stack implementation for storing a basic state machine flow.
  class State
    DEFAULT = :default

    attr_reader :stack

    def initialize
      @stack = []
    end

    def current
      stack.last || DEFAULT
    end

    def push(state)
      stack.push(state)
    end

    def pop
      stack.pop
    end
  end
end
