# frozen_string_literal: true

require 'spec_helper'

describe Nay::Lexer do
  subject(:lexer) { described_class.new(string) }

  describe 'examples' do
    YAML.safe_load(File.read(File.join('spec', 'fixtures', 'examples.yaml'))).each do |example|
      describe example['name'] do
        it 'produces correct tokens' do
          lexer    = described_class.new(example['string'])
          actual   = lexer.rest
          expected = example['tokens'].map { |token| Nay::Token.new(*token) }

          expect(actual).to match_array(expected)
        end
      end
    end
  end
end
