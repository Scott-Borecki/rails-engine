require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Items API', type: :request do
  describe 'POST /api/v1/items' do
    let!(:merchant) { create(:merchant) }
    let(:valid_attributes) do
      {
        name: 'value1',
        description: 'value2',
        unit_price: 100.99,
        merchant_id: merchant.id
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/items', params: valid_attributes }

      it 'creates an item', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:attributes][:name]).to eq(valid_attributes[:name])
        expect(json_data[:attributes][:description]).to eq(valid_attributes[:description])
        expect(json_data[:attributes][:unit_price]).to eq(valid_attributes[:unit_price])
        expect(json_data[:attributes][:merchant_id]).to eq(merchant.id)
      end

      include_examples 'status code 201'
    end

    context 'when the request is invalid' do
      before { post '/api/v1/items', params: { name: 'value1' } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your record could not be saved'
        error_message = [
          'Merchant must exist',
          "Description can't be blank",
          "Unit price can't be blank",
          'Unit price is not a number'
        ]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 422'
    end
  end
end
