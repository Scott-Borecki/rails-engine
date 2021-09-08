require 'rails_helper'

describe Api::V1::Items::MerchantValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide an item id string' do
        it 'creates a valid object' do
          find_params = { item_id: '10' }
          validator = Api::V1::Items::MerchantValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide an item id integer' do
        it 'creates a valid object' do
          find_params = { item_id: 10 }
          validator = Api::V1::Items::MerchantValidator.new(find_params)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      let(:not_a_number_message) { { item_id: ['is not a number'] } }
      let(:missing_item_id_message) { { item_id: ["can't be blank", 'is not a number'] } }

      context 'when I do not provide an item id' do
        it 'returns an invalid object' do
          validator = Api::V1::Items::MerchantValidator.new

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(missing_item_id_message)
        end
      end

      context 'when I provide an item id as a letter string' do
        it 'returns an invalid object' do
          find_params = { item_id: 'my_item_id' }
          validator = Api::V1::Items::MerchantValidator.new(find_params)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(not_a_number_message)
        end
      end

      context 'when I provide an item id as a number/letter string' do
        it 'returns an invalid object' do
          find_params = { item_id: 'item_id_5' }
          validator = Api::V1::Items::MerchantValidator.new(find_params)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(not_a_number_message)
        end
      end
    end
  end
end
