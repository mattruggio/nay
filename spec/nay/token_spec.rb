# frozen_string_literal: true

require 'spec_helper'

describe Nay::Token do
  subject(:token) { described_class.new(type, literal) }

  let(:type)      { 'something' }
  let(:literal)   { 'else' }

  describe '#to_s' do
    it 'contains type' do
      expect(token.to_s).to include(type)
    end

    it 'contains literal' do
      expect(token.to_s).to include(literal)
    end
  end
end
