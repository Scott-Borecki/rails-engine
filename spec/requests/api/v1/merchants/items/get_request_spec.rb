require 'rails_helper'

describe 'Merchant Items API', type: :request do
  describe 'GET /api/v1/merchants/:merchant_id/items' do
    let!(:merchants) { create_list(:merchant, 30) }
    let(:merchant) { merchants.first }

    context 'when the merchant has no items' do
      before { get "/api/v1/merchants/#{merchant.id}/items" }

      it "returns the merchant's items", :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the merchant has items' do
      let!(:merchant_items) { create_list(:item, 15, merchant: merchant) }
      let!(:merchant2_items) { create_list(:item, 25, merchant: merchants.second) }

      before { get "/api/v1/merchants/#{merchant.id}/items" }

      it "returns the merchant's items", :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(15)
        expect(json_data.first[:id]).to eq(merchant.items.first.id.to_s)
        expect(json_data.last[:id]).to eq(merchant.items.last.id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the merchant does not exist' do
      before { get "/api/v1/merchants/40/items" }

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
