require 'rails_helper'

describe 'Revenue Items API', type: :request do
  describe 'GET /api/v1/revenue/items' do
    let(:empty_quantity_message) { { quantity: ["can't be blank", 'is not a number'] } }
    let(:neg_quantity_message) { { quantity: ['must be greater than 0'] } }
    let(:no_number_quantity_message) { { quantity: ['is not a number'] } }

    context 'when there are items' do
      # See /spec/factories/items.rb for #items_with_random_revenue
      let!(:items) { items_with_random_revenue(30) }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/revenue/items' }

        it 'returns a default of ten items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(10)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=22' }

        it 'returns the given number of items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(22)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=0' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(neg_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide a string quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=ten' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(no_number_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(empty_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when there are no items' do
      context 'when I do not provide any query parameters' do
        before { get '/api/v1/revenue/items' }

        it 'returns an empty array', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data).to be_empty
        end

        it 'returns status code 200: ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=20' }

        it 'returns an empty array', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data).to be_empty
        end

        it 'returns status code 200: ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=0' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(neg_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide a string quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=ten' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(no_number_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq(empty_quantity_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
