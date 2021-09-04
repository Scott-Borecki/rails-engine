require 'rails_helper'

describe 'Merchant Serializer', type: :serializer do
  describe 'class methods' do
    describe '.format_merchants' do
      it 'formats the merchants response for delivery' do
        merchants_list = create_list(:merchant, 20)

        merchants = MerchantSerializer.format_merchants(merchants_list)

        expect(merchants).to be_a Hash
        expect(merchants.size).to eq(1)

        expect(merchants).to have_key(:data)
        expect(merchants[:data]).to be_an Array
        expect(merchants[:data].size).to eq(20)

        merchants[:data].each do |merchant|
          expect(merchant).to be_a Hash
          expect(merchant.size).to eq(3)

          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_a String

          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_a String

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a Hash
          expect(merchant[:attributes].size).to eq(1)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a String
        end
      end
    end
  end
end
