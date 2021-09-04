require 'rails_helper'

describe 'Items API', type: :request do
  describe 'GET /api/v1/items' do
    context 'when there are items' do
      let!(:items) { create_list(:item, 30) }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/items' }

        it 'returns items with default of 20 results', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(20)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide per_page query parameters' do
        before { get '/api/v1/items?per_page=25' }

        it 'returns the given number of items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(25)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide page query parameters' do
        before { get '/api/v1/items?page=2' }

        it 'returns the given page of items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(10)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide per_page and page query parameters' do
        before { get '/api/v1/items?page=2&per_page=15' }

        it 'returns the given page and number of items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(15)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when there are no items' do
      before { get '/api/v1/items' }

      it 'returns an empty array', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

# TODO: Add tests for edge cases:
#   - when there are items
#     - per_page = 0:  returns the first page
#     - per_page > number of items:  returns the all items, json_data.size = Item.all.size
#     - page > number of pages:  returns the page with an empty array
#   - when there no items
#     - per_page = 0:  returns the first page with an empty array
