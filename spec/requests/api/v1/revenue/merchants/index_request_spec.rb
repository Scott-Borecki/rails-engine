require 'rails_helper'

describe 'Revenue Merchants API', type: :request do
  describe 'GET /api/v1/revenue/merchants' do
    context 'when there are merchants' do
      # See /spec/factories/merchants.rb for #merchants_with_revenue
      let!(:merchants) { merchants_with_random_revenue(30) }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/revenue/merchants' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["can't be blank"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=22' }

        it 'returns the given number of merchants', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(22)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=0' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["must be greater than 0"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["can't be blank", "is not a number"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when there are no merchants' do
      context 'when I do not provide any query parameters' do
        before { get '/api/v1/revenue/merchants' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["can't be blank"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=20' }

        it 'returns an empty array', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data).to be_empty
        end

        it 'returns status code 200: ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=0' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["must be greater than 0"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/merchants?quantity=' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(3)

          expect(json[:error]).to be_a Hash
          expect(json[:error]).to eq({:quantity=>["can't be blank", "is not a number"]})
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
