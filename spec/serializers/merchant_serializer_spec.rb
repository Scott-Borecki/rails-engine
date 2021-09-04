require 'rails_helper'

describe 'MerchantSerializer', type: :serializer do
  describe 'class methods' do
    describe '.format_merchants' do
      it 'formats the merchants response for delivery', :aggregate_failures do
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
          expect(merchant[:type]).to eq('merchant')

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a Hash
          expect(merchant[:attributes].size).to eq(1)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a String
        end
      end
    end

    describe '.format_merchant' do
      it 'formats the single merchant response for delivery', :aggregate_failures do
        merchant = create(:merchant)

        merchant = MerchantSerializer.format_merchant(merchant)

        expect(merchant).to be_a Hash
        expect(merchant.size).to eq(1)

        expect(merchant).to have_key(:data)

        merchant_data = merchant[:data]

        expect(merchant_data).to be_a Hash
        expect(merchant_data.size).to eq(3)

        expect(merchant_data).to have_key(:id)
        expect(merchant_data[:id]).to be_a String

        expect(merchant_data).to have_key(:type)
        expect(merchant_data[:type]).to be_a String
        expect(merchant_data[:type]).to eq('merchant')

        expect(merchant_data).to have_key(:attributes)
        expect(merchant_data[:attributes]).to be_a Hash
        expect(merchant_data[:attributes].size).to eq(1)

        expect(merchant_data[:attributes]).to have_key(:name)
        expect(merchant_data[:attributes][:name]).to be_a String
      end
    end
  end
end
