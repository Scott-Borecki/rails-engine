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
  end
end
