# frozen_string_literal: true

require 'spec_helper'

describe Nay do
  describe 'examples' do
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
