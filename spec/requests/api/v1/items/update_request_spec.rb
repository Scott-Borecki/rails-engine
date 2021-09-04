require 'rails_helper'

describe 'Items API', type: :request do
  describe 'PATCH /api/v1/items/:id' do
    let!(:merchant) { create(:merchant) }
    let(:message404) { 'your query could not be completed' }
    let(:message422) { 'your record could not be saved' }

    context 'when the item does not exist' do
      let(:valid_attributes) { { name: 'Shiny New Car' } }

      before { patch '/api/v1/items/1', params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        error_message = ["Couldn't find Item with 'id'=1"]

        expect(json[:message]).to eq(message404)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      it 'returns status code 404: not found' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the item exists' do
      let!(:item) { create(:item, merchant: merchant) }

      context 'when the request is valid' do
        let(:valid_attributes) { { name: 'Shiny New Car' } }

        before { patch "/api/v1/items/#{item.id}", params: valid_attributes }

        it 'updates the item', :aggregate_failures do
          item.reload

          expect(json).not_to be_empty
          expect(json_data.size).to eq(3)
          expect(json_data[:attributes].size).to eq(4)
          expect(json_data[:attributes][:name]).to eq('Shiny New Car')
          expect(json_data[:attributes][:description]).to eq(item.description)
          expect(json_data[:attributes][:unit_price]).to eq(item.unit_price)
          expect(json_data[:attributes][:merchant_id]).to eq(merchant.id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when the request is invalid; unit_price not a number' do
        let(:invalid_attributes) { { unit_price: 'some_price' } }

        before { patch "/api/v1/items/#{item.id}", params: invalid_attributes }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(2)

          error_message = ['Unit price is not a number']

          expect(json[:message]).to eq(message422)
          expect(json[:errors]).to be_an Array
          expect(json[:errors]).to eq(error_message)
        end

        it 'returns status code 422: unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the request is invalid; merchant does not exist' do
        let(:bad_merchant_id) { merchant.id + 1 }
        let(:invalid_attributes) { { merchant_id: bad_merchant_id } }

        before { patch "/api/v1/items/#{item.id}", params: invalid_attributes }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(2)

          error_message = ["Couldn't find Merchant with 'id'=#{bad_merchant_id}"]

          expect(json[:message]).to eq(message404)
          expect(json[:errors]).to be_an Array
          expect(json[:errors]).to eq(error_message)
        end

        it 'returns status code 404: not found' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
