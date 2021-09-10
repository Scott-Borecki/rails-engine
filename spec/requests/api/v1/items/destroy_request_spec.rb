require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Items API', type: :request do
  describe 'DELETE /api/v1/items/:id' do
    let!(:merchant) { create(:merchant) }
    let!(:item) { create(:item, merchant: merchant) }

    context 'when the item exists' do
      before { delete "/api/v1/items/#{item.id}" }

      include_examples 'status code 204'
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

      include_examples 'status code 404'
    end
  end
end
