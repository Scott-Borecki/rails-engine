require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
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

        include_examples 'status code 200'
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=22' }

        it 'returns the given number of items', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(22)
        end

        include_examples 'status code 200'
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=0' }

        include_examples 'bad query: negative quantity'
        include_examples 'status code 400'
      end

      context 'when I provide a string quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=ten' }

        include_examples 'bad query: quantity not a number'
        include_examples 'status code 400'
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=' }

        include_examples 'bad query: empty quantity'
        include_examples 'status code 400'
      end
    end

    context 'when there are no items' do
      context 'when I do not provide any query parameters' do
        before { get '/api/v1/revenue/items' }

        include_examples 'returns nil data'
        include_examples 'status code 200'
      end

      context 'when I provide valid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=20' }

        include_examples 'returns nil data'
        include_examples 'status code 200'
      end

      context 'when I provide invalid quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=0' }

        include_examples 'bad query: negative quantity'
        include_examples 'status code 400'
      end

      context 'when I provide a string quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=ten' }

        include_examples 'bad query: quantity not a number'
        include_examples 'status code 400'
      end

      context 'when I provide empty quantity query parameters' do
        before { get '/api/v1/revenue/items?quantity=' }

        include_examples 'bad query: empty quantity'
        include_examples 'status code 400'
      end
    end
  end
end
