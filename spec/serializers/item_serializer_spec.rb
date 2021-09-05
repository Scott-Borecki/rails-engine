require 'rails_helper'

describe 'ItemSerializer', type: :serializer do
  describe 'class methods' do
    describe '.format_items' do
      context 'when I provide valid items' do
        it 'formats the items response for delivery', :aggregate_failures do
          items_list = create_list(:item, 20)

          items = ItemSerializer.format_items(items_list)

          expect(items).to be_a Hash
          expect(items.size).to eq(1)

          expect(items).to have_key(:data)
          expect(items[:data]).to be_an Array
          expect(items[:data].size).to eq(20)

          items[:data].each do |item|
            expect(item).to be_a Hash
            expect(item.size).to eq(3)

            expect(item).to have_key(:id)
            expect(item[:id]).to be_a String

            expect(item).to have_key(:type)
            expect(item[:type]).to be_a String
            expect(item[:type]).to eq('item')

            expect(item).to have_key(:attributes)
            expect(item[:attributes]).to be_a Hash
            expect(item[:attributes].size).to eq(4)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_a String

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_a String

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_a Float

            expect(item[:attributes]).to have_key(:merchant_id)
            expect(item[:attributes][:merchant_id]).to be_an Integer
          end
        end

        context 'when I provide no valid items' do
          it 'returns a hash with data as nil' do
            empty_items = ItemSerializer.format_items(nil)

            expect(empty_items).to be_a Hash
            expect(empty_items.size).to eq(1)

            expect(empty_items).to have_key(:data)
            expect(empty_items[:data]).to be_a Hash
            expect(empty_items[:data]).to be_empty
          end
        end
      end
    end

    describe '.format_item' do
      context 'when I provide a valid item' do
        it 'formats the single item response for delivery', :aggregate_failures do
          item = create(:item)

          item = ItemSerializer.format_item(item)

          expect(item).to be_a Hash
          expect(item.size).to eq(1)

          expect(item).to have_key(:data)

          item_data = item[:data]

          expect(item_data).to be_a Hash
          expect(item_data.size).to eq(3)

          expect(item_data).to have_key(:id)
          expect(item_data[:id]).to be_a String

          expect(item_data).to have_key(:type)
          expect(item_data[:type]).to be_a String
          expect(item_data[:type]).to eq('item')

          expect(item_data).to have_key(:attributes)
          expect(item_data[:attributes]).to be_a Hash
          expect(item_data[:attributes].size).to eq(4)

          expect(item_data[:attributes]).to have_key(:name)
          expect(item_data[:attributes][:name]).to be_a String

          expect(item_data[:attributes]).to have_key(:description)
          expect(item_data[:attributes][:description]).to be_a String

          expect(item_data[:attributes]).to have_key(:unit_price)
          expect(item_data[:attributes][:unit_price]).to be_a Float

          expect(item_data[:attributes]).to have_key(:merchant_id)
          expect(item_data[:attributes][:merchant_id]).to be_an Integer
        end
      end

      context 'when I provide no valid item' do
        it 'returns a hash with data as nil' do
          empty_item = ItemSerializer.format_item(nil)

          expect(empty_item).to be_a Hash
          expect(empty_item.size).to eq(1)

          expect(empty_item).to have_key(:data)
          expect(empty_item[:data]).to be_a Hash
          expect(empty_item[:data]).to be_empty
        end
      end
    end
  end
end
