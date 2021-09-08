require 'rails_helper'

describe 'Merchants Find API', type: :request do
  describe 'GET /api/v1/merchants/find' do
    context 'when there are merchant records' do
      let!(:merchant1) { create(:merchant, name: 'BaA') } # Asc Order: 2
      let!(:merchant2) { create(:merchant, name: 'bac') } # Asc Order: 5
      let!(:merchant3) { create(:merchant, name: 'bAA') } # Asc Order: 4
      let!(:merchant4) { create(:merchant, name: 'Bab') } # Asc Order: 3
      let!(:merchant5) { create(:merchant, name: 'BAa') } # Asc Order: 1
      let(:merchants_aa) { [merchant5, merchant1, merchant3] }

      let(:blank_name_message) { { name: ["can't be blank"] } }

      context 'when I do not provide any query parameters' do
        before { get '/api/v1/merchants/find' }

        it 'returns a jSON object with an error', :aggregate_failures do
          expect(json).to have_key(:error)
          expect(json[:error]).to eq(blank_name_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I provide an empty query parameter' do
        before { get '/api/v1/merchants/find?name=' }

        it 'returns a jSON object with an error', :aggregate_failures do
          expect(json).to have_key(:error)
          expect(json[:error]).to eq(blank_name_message)
        end

        it 'returns status code 400: bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when I search by name' do
        before { get '/api/v1/merchants/find?name=aa' }

        it 'returns the first merchant matching the search by case-sensitive alphabetical order', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json_data.size).to eq(3)
          expect(json_data[:id]).to eq(merchant5.id.to_s)
        end

        it 'returns status code 200: ok' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when there are no merchant records' do
      before { get '/api/v1/merchants/find?name=ccc' }

      it 'returns a jSON with nil data', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data).to be_empty
      end

      it 'returns status code 200: ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
