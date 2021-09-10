require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Merchant Items API', type: :request do
  describe 'GET /api/v1/merchants/:merchant_id/items' do
    let!(:merchants) { create_list(:merchant, 30) }
    let(:merchant) { merchants.first }
    let(:bad_merchant_id) { Merchant.last.id + 1 }

    context 'when the merchant does not exist' do
      before { get "/api/v1/merchants/#{bad_merchant_id}/items" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Merchant with 'id'=#{bad_merchant_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the merchant has no items' do
      before { get "/api/v1/merchants/#{merchant.id}/items" }

      include_examples 'returns nil data'
      include_examples 'status code 200'
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

      include_examples 'status code 200'
    end

    context 'when the merchant id is given as a string' do
      before { get '/api/v1/merchants/some-string/items' }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)

        expect(json[:error]).to be_a Hash
        expect(json[:error]).to eq({ merchant_id: ['is not a number'] })
      end

      include_examples 'status code 404'
    end
  end
end
