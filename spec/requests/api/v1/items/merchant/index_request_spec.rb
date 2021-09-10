require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Item Merchant API', type: :request do
  describe 'GET /api/v1/items/:item_id/merchant' do
    let(:merchant) { create(:merchant) }

    context 'when the item does not exist' do
      before { get '/api/v1/items/1/merchant' }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Item with 'id'=1"])
      end

      include_examples 'status code 404'
    end

    context 'when the item exists' do
      let!(:item) { create(:item, merchant: merchant) }

      before { get "/api/v1/items/#{item.id}/merchant" }

      it 'returns the merchant associated with the item', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(merchant.id.to_s)
      end

      include_examples 'status code 200'
    end

    context 'when the item id is given as a string' do
      before { get '/api/v1/items/some-string/merchant' }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)

        expect(json[:error]).to be_a Hash
        expect(json[:error]).to eq({ item_id: ['is not a number'] })
      end

      include_examples 'status code 404'
    end
  end
end
