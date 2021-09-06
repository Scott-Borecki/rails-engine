require 'rails_helper'

describe 'RevenueSerializer', type: :serializer do
  describe 'class methods' do
    describe '.format_merchant_revenue' do
      it 'formats the merchant revenue response for delivery', :aggregate_failures do
        # See /spec/factories/merchants.rb for #merchant_with_revenue
        merchant = merchant_with_revenue
        merchant_revenue = RevenueSerializer.format_merchant_revenue(merchant)

        expect(merchant_revenue).to be_a Hash
        expect(merchant_revenue.size).to eq(1)

        expect(merchant_revenue).to have_key(:data)

        merchant_revenue_data = merchant_revenue[:data]

        expect(merchant_revenue_data).to be_a Hash
        expect(merchant_revenue_data.size).to eq(3)

        expect(merchant_revenue_data).to have_key(:id)
        expect(merchant_revenue_data[:id]).to be_a String
        expect(merchant_revenue_data[:id]).to eq(merchant.id.to_s)

        expect(merchant_revenue_data).to have_key(:type)
        expect(merchant_revenue_data[:type]).to be_a String
        expect(merchant_revenue_data[:type]).to eq('merchant_revenue')

        expect(merchant_revenue_data).to have_key(:attributes)
        expect(merchant_revenue_data[:attributes]).to be_a Hash
        expect(merchant_revenue_data[:attributes].size).to eq(1)

        expect(merchant_revenue_data[:attributes]).to have_key(:revenue)
        expect(merchant_revenue_data[:attributes][:revenue]).to be_a Float
        expect(merchant_revenue_data[:attributes][:revenue]).to eq(merchant.total_revenue_generated)
      end
    end

    describe '.format_merchants_revenue' do
      it 'formats the merchants response for delivery', :aggregate_failures do
        # See /spec/factories/merchants.rb for #merchants_with_revenue
        merchants_with_revenue(15)
        merchants = Merchant.top_by_revenue(15)
        merchants_revenue = RevenueSerializer.format_merchants_revenue(merchants)

        expect(merchants_revenue).to be_a Hash
        expect(merchants_revenue.size).to eq(1)

        expect(merchants_revenue).to have_key(:data)
        expect(merchants_revenue[:data]).to be_an Array
        expect(merchants_revenue[:data].size).to eq(15)

        merchants_revenue[:data].each do |merchant_revenue|
          expect(merchant_revenue).to be_a Hash
          expect(merchant_revenue.size).to eq(3)

          expect(merchant_revenue).to have_key(:id)
          expect(merchant_revenue[:id]).to be_a String

          expect(merchant_revenue).to have_key(:type)
          expect(merchant_revenue[:type]).to be_a String
          expect(merchant_revenue[:type]).to eq('merchant_name_revenue')

          expect(merchant_revenue).to have_key(:attributes)
          expect(merchant_revenue[:attributes]).to be_a Hash
          expect(merchant_revenue[:attributes].size).to eq(2)

          expect(merchant_revenue[:attributes]).to have_key(:name)
          expect(merchant_revenue[:attributes][:name]).to be_a String

          expect(merchant_revenue[:attributes]).to have_key(:revenue)
          expect(merchant_revenue[:attributes][:revenue]).to be_a Float
        end

        first_merchant = merchants.first
        first_merchant_data = merchants_revenue[:data].first
        first_merchant_attrs = first_merchant_data[:attributes]

        expect(first_merchant_data[:id]).to eq(first_merchant.id.to_s)
        expect(first_merchant_attrs[:name]).to eq(first_merchant.name)
        expect(first_merchant_attrs[:revenue]).to eq(first_merchant.total_revenue)
      end
    end
  end
end
