require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Revenue Merchants API', type: :request do
  describe 'GET /api/v1/revenue/merchants/:id' do
    # See /spec/factories/merchants.rb for #merchant_with_revenue
    let!(:merchant) { merchant_with_revenue }
    let(:merchant_id) { merchant.id }

    context 'when the merchant record exists' do
      before { get "/api/v1/revenue/merchants/#{merchant_id}" }

      it 'returns the merchant revenue', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(merchant_id.to_s)
        expect(json_data[:type]).to eq('merchant_revenue')
        expect(json_data[:attributes][:revenue]).to eq(merchant.total_revenue_generated)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the merchant record does not exist' do
      let(:bad_merchant_id) { Merchant.last.id + 1 }

      before { get "/api/v1/revenue/merchants/#{bad_merchant_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Merchant with 'id'=#{bad_merchant_id}"])
      end

      it 'returns status code 404: not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
