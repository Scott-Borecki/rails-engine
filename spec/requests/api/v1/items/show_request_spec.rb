require 'rails_helper'

describe 'Items API', type: :request do
  describe 'SHOW /api/v1/items/:id' do
    let!(:items) { create_list(:item, 30) }
    let(:item_id) { items.first.id }

    context 'when the item record exists' do
      before { get "/api/v1/items/#{item_id}" }

      it 'returns the item', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(item_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
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

      it 'returns status code 404: not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
