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

    context 'with two numbers' do
      it 'returns their sum' do
        expect(StringCalculator.add("1,2")).to eq(3)
        expect(StringCalculator.add("7,8")).to eq(15)
      end
    end

    context 'with unknown amount of numbers' do
      it 'returns sum of all numbers' do
        expect(StringCalculator.add("1,2,3")).to eq(6)
        expect(StringCalculator.add("1,2,3,4,5")).to eq(15)
      end
    end

    context 'with new lines between numbers' do
      it 'treats newlines as delimiters' do
        expect(StringCalculator.add("1\n2,3")).to eq(6)
        expect(StringCalculator.add("1,2\n3")).to eq(6)
      end
    end

    context 'with custom delimiters' do
      it 'uses specified delimiter' do
        expect(StringCalculator.add("//;\n1;2")).to eq(3)
        expect(StringCalculator.add("//|\n1|2|3")).to eq(6)
        expect(StringCalculator.add("//*\n1*2*3*4")).to eq(10)
      end
    end

    context 'with negative numbers' do
      it 'throws exception for single negative' do
        expect { StringCalculator.add("1,-2,3") }.to raise_error(
          ArgumentError, "negatives not allowed: -2"
        )
      end

      it 'shows all negatives in exception message' do
        expect { StringCalculator.add("1,-2,-3,4") }.to raise_error(
          ArgumentError, "negatives not allowed: -2, -3"
        )
      end

      it 'throws exception with custom delimiter' do
        expect { StringCalculator.add("//;\n1;-2;3") }.to raise_error(
          ArgumentError, "negatives not allowed: -2"
        )
      end
    end

    context 'with numbers bigger than 1000' do
      it 'ignores numbers greater than 1000' do
        expect(StringCalculator.add("5,1001")).to eq(5)
        expect(StringCalculator.add("1000,2,1001")).to eq(1002)
        expect(StringCalculator.add("1,2,3,3000")).to eq(6)
      end

      it 'includes 1000 but ignores 1001' do
        expect(StringCalculator.add("1000,1001")).to eq(1000)
      end
    end

    context 'with delimiters of any length' do
      it 'handles multi-character delimiters' do
        expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
        expect(StringCalculator.add("//[abc]\n1abc2abc3abc4")).to eq(10)
        expect(StringCalculator.add("//[|||]\n5|||10|||20")).to eq(35)
      end
    end
  end
end
