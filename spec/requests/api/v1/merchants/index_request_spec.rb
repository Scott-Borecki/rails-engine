require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants' do
    context 'when there are merchants' do
      let!(:merchants) { create_list(:merchant, 30) }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/merchants' }

        it 'returns merchants with default of 20 results', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(20)
        end

        include_examples 'status code 200'
      end

      context 'when I provide per_page query parameters' do
        before { get '/api/v1/merchants?per_page=25' }

        it 'returns the given number of merchants', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(25)
        end

        include_examples 'status code 200'
      end

      context 'when I provide page query parameters' do
        before { get '/api/v1/merchants?page=2' }

        it 'returns the given page of merchants', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(10)
        end

        include_examples 'status code 200'
      end

      context 'when I provide per_page and page query parameters' do
        before { get '/api/v1/merchants?page=2&per_page=15' }

        it 'returns the given page and number of merchants', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(15)
        end

        include_examples 'status code 200'
      end
    end

    context 'when there are no merchants' do
      before { get '/api/v1/merchants' }

      include_examples 'returns nil data'
      include_examples 'status code 200'
    end
  end
end
