require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '.find_by_price_range' do
    let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
    let!(:item2) { create(:item, name: 'baa', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
    let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
    let!(:item4) { create(:item, name: 'Baa', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
    let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4

    context 'when I provide a valid price range' do
      context 'when there are items within the price range' do
        it 'returns the first item by case-sensitive alphabetical order', :aggregate_failures do
          # It accepts a float price
          expect(Item.find_by_price_range(7.24, 9.99)).to eq(item4)
          # It accepts a string float price
          expect(Item.find_by_price_range('7.24', '9.99')).to eq(item4)
          # It accepts an integer price
          expect(Item.find_by_price_range(3, 7)).to eq(item5)
          # It accepts a string integer price
          expect(Item.find_by_price_range('3', '7')).to eq(item5)
          # It evaluates the price as greater/less than or equal to
          expect(Item.find_by_price_range(7.53, 8.32)).to eq(item4)
        end
      end

      context 'when there are no items within the price range' do
        it 'returns nil' do
          expect(Item.find_by_price_range(10, 20)).to eq(nil)
        end
      end
    end

    context 'when I provide an invalid price range with a string' do
      it 'returns nil', :aggregate_failures do
        expect(Item.find_by_price_range('one', 1)).to eq(nil)
        expect(Item.find_by_price_range(1, 'one1')).to eq(nil)
        expect(Item.find_by_price_range('1one', 1)).to eq(nil)
      end
    end

    context 'when I provide a negative minimum or maximum price' do
      it 'returns "bad request"', :aggregate_failures do
        expect(Item.find_by_price_range(-10, 5)).to eq('bad request')
        expect(Item.find_by_price_range(10, -5)).to eq('bad request')
        expect(Item.find_by_price_range(-10, -5)).to eq('bad request')
      end
    end

    context 'when I provide a minimum price greater than the maximum price' do
      it 'returns "bad request"' do
        expect(Item.find_by_price_range(10, 1)).to eq('bad request')
      end
    end
  end
end
