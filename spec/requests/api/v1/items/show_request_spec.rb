require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Items API', type: :request do
  describe 'GET /api/v1/items/:id' do
    let!(:items) { create_list(:item, 30) }
    let(:item_id) { items.first.id }

    context 'when the item record exists' do
      before { get "/api/v1/items/#{item_id}" }

      it 'returns the item', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(item_id.to_s)
      end

      include_examples 'status code 200'
    end

    context 'when the item record does not exist' do
      before { get '/api/v1/items/40' }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Item with 'id'=40"])
      end

      include_examples 'status code 404'
    end
  end
end
