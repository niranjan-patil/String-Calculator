require 'rspec'
require_relative '../string_calculator'

RSpec.describe StringCalculator do
  describe ".add" do
    context 'with empty string' do
      it 'returns 0' do
        expect(StringCalculator.add("")).to eq(0)
      end
    end

    context 'with single number' do
      it 'returns the number itself' do
        expect(StringCalculator.add("1")).to eq(1)
        expect(StringCalculator.add("7")).to eq(7)
      end
    end
  end
end
