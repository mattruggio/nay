# frozen_string_literal: true

require 'spec_helper'

describe Nay::Template do
  subject(:template) { described_class.new(object) }

  describe '#evaluate' do
    context 'when expression is a string' do
      let(:object) { '<< d.e >>' }

      let(:values) do
        { 'd' => { 'e' => 'f' } }
      end

      it 'renders interpolations' do
        actual = template.evaluate(values)

        expect(actual).to eq('f')
      end
    end

    context 'when expression is an array' do
      let(:object) do
        ['<< a >>', '<< b >>']
      end

      let(:values) do
        { 'a' => '1', 'b' => 2 }
      end

      it 'renders interpolations' do
        actual = template.evaluate(values)

        expect(actual).to eq(%w[1 2])
      end
    end

    context 'when expression is a hash' do
      let(:object) do
        {
          '<< "key_a" >>' => ['<< a >>'],
          'b' => '<< b >>'
        }
      end

      let(:values) do
        { 'a' => '1', 'b' => 2, 'key_a' => 'a' }
      end

      it 'renders interpolations' do
        actual = template.evaluate(values)

        expect(actual).to eq({ 'a' => ['1'], 'b' => '2' })
      end
    end
  end
end
