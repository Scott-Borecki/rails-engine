require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Merchants Most Items API', type: :request do
  describe 'GET /api/v1/merchants/most_items' do
    let(:blank_quantity_message) { { quantity: ["can't be blank"] } }
    let(:empty_quantity_message) { { quantity: ["can't be blank", 'is not a number'] } }
    let(:neg_quantity_message) { { quantity: ['must be greater than 0'] } }

    context 'when there are merchants' do
      # See /spec/factories/merchants.rb for #merchants_with_random_revenue
      let!(:merchants) { merchants_with_random_revenue(30) }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/merchants/most_items' }

        include_examples 'bad query: blank quantity'
        include_examples 'status code 400'
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=22' }

        it 'returns the given number of merchants', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(22)
        end

        include_examples 'status code 200'
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=0' }

        include_examples 'bad query: negative quantity'
        include_examples 'status code 400'
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=' }

        include_examples 'bad query: empty quantity'
        include_examples 'status code 400'
      end
    end

    context 'when there are no merchants' do
      context 'when I do not provide any query parameters' do
        before { get '/api/v1/merchants/most_items' }

        include_examples 'bad query: blank quantity'
        include_examples 'status code 400'
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=20' }

        include_examples 'returns nil data'
        include_examples 'status code 200'
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=0' }

        include_examples 'bad query: negative quantity'
        include_examples 'status code 400'
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/merchants/most_items?quantity=' }

        include_examples 'bad query: empty quantity'
        include_examples 'status code 400'
      end
    end
  end
end
