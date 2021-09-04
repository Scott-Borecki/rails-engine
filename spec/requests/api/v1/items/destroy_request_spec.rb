require 'rails_helper'

describe 'Items API', type: :request do
  describe 'DELETE /api/v1/items/:id' do
    let!(:merchant) { create(:merchant) }
    let!(:item) { create(:item, merchant: merchant) }

    context 'when the item exists' do
      before { delete "/api/v1/items/#{item.id}" }

      it 'returns status code 204: no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the item does not exist' do
      let(:bad_item_id) { item.id + 1 }
      
      before { delete "/api/v1/items/#{bad_item_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Item with 'id'=#{bad_item_id}"])
      end

      it 'returns status code 404: not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

# TODO: Add tests for edge cases:
#   - destroy any invoice if this was the only item on an invoice
