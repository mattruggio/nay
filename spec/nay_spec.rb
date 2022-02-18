# frozen_string_literal: true

require 'spec_helper'

describe Nay do
  describe 'examples' do
    context 'when object is a complex object' do
      let(:object) do
        {
          '<< id_key >>' => '<< id >>',
          'pets' => [
            '<< pets."pet 1" >>',
            '<< pets."pet 2" >>'
          ],
          zyx: :vut
        }
      end

      let(:parameters) do
        {
          'id_key' => 'id',
          'id' => 123,
          'pets' => {
            'pet 1' => 'dog',
            'pet 2' => 'cat'
          }
        }
      end

      it 'evaluates against parameters' do
        actual = described_class.evaluate(object, parameters)

        expected = {
          'id' => '123',
          'pets' => %w[dog cat],
          zyx: :vut
        }

        expect(actual).to eq(expected)
      end
    end

    read_yaml_fixture('examples.yaml').each do |example|
      example['evaluations'].each do |evaluation|
        describe "#{example['name']} with #{evaluation['name']}" do
          it 'generates correct output' do
            string    = example['string']
            input     = evaluation['input']
            actual    = described_class.evaluate(string, input)
            expected  = evaluation['output']

            expect(actual).to eq(expected)
          end
        end
      end
    end
  end
end
