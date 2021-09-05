require 'rails_helper'

describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/:id' do
    let!(:merchants) { create_list(:merchant, 30) }
    let(:merchant_id) { merchants.first.id }

    context 'when the merchant record exists' do
      before { get "/api/v1/merchants/#{merchant_id}" }

      it 'returns the merchant', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(merchant_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the merchant record does not exist' do
      before { get '/api/v1/merchants/40' }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Merchant with 'id'=40"])
      end

      it 'returns status code 404: not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
