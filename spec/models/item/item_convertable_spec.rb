require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'inherited Convertable methods' do
    describe '.convert_to_float' do
      context 'when I provide a float string' do
        it 'returns a float', :aggregate_failures do
          expect(Item.convert_to_float('5.25')).to be_a Float
          expect(Item.convert_to_float('5.25')).to eq(5.25)
        end
      end

      context 'when I provide a float' do
        it 'returns a float', :aggregate_failures do
          expect(Item.convert_to_float(5.25)).to be_a Float
          expect(Item.convert_to_float(5.25)).to eq(5.25)
        end
      end

      context 'when I provide an integer string' do
        it 'returns a float', :aggregate_failures do
          expect(Item.convert_to_float('5')).to be_a Float
          expect(Item.convert_to_float('5')).to eq(5.0)
        end
      end

      context 'when I provide an integer' do
        it 'returns a float', :aggregate_failures do
          expect(Item.convert_to_float(5)).to be_a Float
          expect(Item.convert_to_float(5)).to eq(5.0)
        end
      end

      context 'when I provide a non-numeric string' do
        it 'returns nil', :aggregate_failures do
          expect(Item.convert_to_float('one')).to be_nil
          expect(Item.convert_to_float('one1')).to be_nil
          expect(Item.convert_to_float('1one')).to be_nil
        end
      end
    end
  end
end
