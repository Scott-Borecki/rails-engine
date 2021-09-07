require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'find by price methods' do
    let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
    let!(:item2) { create(:item, name: 'bac', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
    let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
    let!(:item4) { create(:item, name: 'Bab', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
    let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4

    describe '.find_all_by_max_price' do
      context 'when I provide a valid maximum price' do
        context 'when there are items with a unit price less than the maximum price' do
          it 'returns the first item by case-sensitive alphabetical order', :aggregate_failures do
            # It accepts a float price
            expect(Item.find_all_by_max_price(7.24)).to eq([item5, item1])
            # It accepts a string float price
            expect(Item.find_all_by_max_price('7.24')).to eq([item5, item1])
            # It accepts an integer price
            expect(Item.find_all_by_max_price(6)).to eq([item1])
            # It accepts a string integer price
            expect(Item.find_all_by_max_price('6')).to eq([item1])
            # It evaluates the price as less than or equal to
            expect(Item.find_all_by_max_price(5.25)).to eq([item1])
          end
        end

        context 'when there are no items with a unit price less than the maximum price' do
          it 'returns nil' do
            expect(Item.find_all_by_max_price(1)).to eq([])
          end
        end
      end

      context 'when I provide an invalid maximum price' do
        it 'returns nil', :aggregate_failures do
          expect(Item.find_all_by_max_price('ten')).to eq(nil)
          expect(Item.find_all_by_max_price('ten10')).to eq(nil)
          expect(Item.find_all_by_max_price('10ten')).to eq(nil)
        end
      end

      context 'when I provide a negative maximum price' do
        it 'returns "bad request"' do
          expect(Item.find_all_by_max_price(-10)).to eq('bad request')
        end
      end
    end

    describe '.find_all_by_min_price' do
      context 'when I provide a valid minimum price' do
        context 'when there are items with a unit price more than the minimum price' do
          it 'returns the first item by case-sensitive alphabetical order', :aggregate_failures do
            # It accepts a float price
            expect(Item.find_all_by_min_price(7.24)).to eq([item4, item3, item2])
            # It accepts a string float price
            expect(Item.find_all_by_min_price('7.24')).to eq([item4, item3, item2])
            # It accepts an integer price
            expect(Item.find_all_by_min_price(3)).to eq([item5, item1, item4, item3, item2])
            # It accepts a string integer price
            expect(Item.find_all_by_min_price('3')).to eq([item5, item1, item4, item3, item2])
            # It evaluates the price as greater than or equal to
            expect(Item.find_all_by_min_price(8.32)).to eq([item4, item3])
          end
        end

        context 'when there are no items with a unit price more than the minimum price' do
          it 'returns nil' do
            expect(Item.find_all_by_min_price(10)).to eq([])
          end
        end
      end

      context 'when I provide an invalid minimum price' do
        it 'returns nil', :aggregate_failures do
          expect(Item.find_all_by_min_price('one')).to eq(nil)
          expect(Item.find_all_by_min_price('one1')).to eq(nil)
          expect(Item.find_all_by_min_price('1one')).to eq(nil)
        end
      end

      context 'when I provide a negative minimum price' do
        it 'returns "bad request"' do
          expect(Item.find_all_by_min_price(-10)).to eq('bad request')
        end
      end
    end

    describe '.find_all_by_price_range' do
      context 'when I provide a valid price range' do
        context 'when there are items within the price range' do
          it 'returns the first item by case-sensitive alphabetical order', :aggregate_failures do
            # It accepts a float price
            expect(Item.find_all_by_price_range(7.24, 9.99)).to eq([item4, item3, item2])
            # It accepts a string float price
            expect(Item.find_all_by_price_range('7.24', '9.99')).to eq([item4, item3, item2])
            # It accepts an integer price
            expect(Item.find_all_by_price_range(3, 7)).to eq([item5, item1])
            # It accepts a string integer price
            expect(Item.find_all_by_price_range('3', '7')).to eq([item5, item1])
            # It evaluates the price as greater/less than or equal to
            expect(Item.find_all_by_price_range(7.53, 8.32)).to eq([item4, item2])
          end
        end

        context 'when there are no items within the price range' do
          it 'returns nil' do
            expect(Item.find_all_by_price_range(10, 20)).to eq([])
          end
        end
      end

      context 'when I provide an invalid price range with a string' do
        it 'returns nil', :aggregate_failures do
          expect(Item.find_all_by_price_range('one', 1)).to eq(nil)
          expect(Item.find_all_by_price_range(1, 'one1')).to eq(nil)
          expect(Item.find_all_by_price_range('1one', 1)).to eq(nil)
        end
      end

      context 'when I provide a negative minimum or maximum price' do
        it 'returns "bad request"', :aggregate_failures do
          expect(Item.find_all_by_price_range(-10, 5)).to eq('bad request')
          expect(Item.find_all_by_price_range(10, -5)).to eq('bad request')
          expect(Item.find_all_by_price_range(-10, -5)).to eq('bad request')
        end
      end

      context 'when I provide a minimum price greater than the maximum price' do
        it 'returns "bad request"' do
          expect(Item.find_all_by_price_range(10, 1)).to eq('bad request')
        end
      end
    end
  end
end
