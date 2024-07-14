require 'rspec'
require_relative 'string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  context 'Basic scenarios' do
    it 'returns 0 for an empty string' do
      expect(calculator.add('')).to eq(0)
    end

    it 'returns the number itself for a single number input' do
      expect(calculator.add('1')).to eq(1)
    end

    it 'returns the sum of two numbers separated by comma' do
      expect(calculator.add('1,2')).to eq(3)
    end
  end

  context 'Unknown amount of numbers' do
    it 'handles multiple numbers separated by commas' do
      expect(calculator.add('1,2,3,4')).to eq(10)
    end
  end

  context 'New lines between numbers' do
    it 'handles numbers separated by new lines and commas' do
      expect(calculator.add('1\n2,3')).to eq(6)
    end
  end

  context 'Different delimiters' do
    it 'handles custom delimiter format //[delimiter]\n[numbers]' do
      expect(calculator.add('//;\n1;2')).to eq(3)
    end
  end

  context 'Negative numbers' do
    it 'raises an exception for negative numbers' do
      expect { calculator.add('1,-2,3,-4') }.to raise_error('Negative numbers not allowed: -2, -4')
    end
  end

  context 'Numbers greater than 1000' do
    it 'ignores numbers greater than 1000 in the sum' do
      expect(calculator.add('2,1001,3')).to eq(5)
    end
  end

  context 'Delimiters of any length' do
    it 'handles custom delimiter of any length //[delimiter]\n[numbers]' do
      expect(calculator.add('//[***]\n1***2***3')).to eq(6)
    end
  end

  context 'Multiple delimiters' do
    it 'handles multiple custom delimiters //[delim1][delim2]\n[numbers]' do
      expect(calculator.add('//[*][%]\n1*2%3')).to eq(6)
    end
  end
end
