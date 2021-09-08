require 'rails_helper'

describe Api::V1::Merchants::ItemsValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide an merchant id string' do
        it 'creates a valid object' do
          find_params = { merchant_id: '10' }
          validator = Api::V1::Merchants::ItemsValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide an merchant id integer' do
        it 'creates a valid object' do
          find_params = { merchant_id: 10 }
          validator = Api::V1::Merchants::ItemsValidator.new(find_params)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide an merchant id' do
        it 'returns an invalid object' do
          validator = Api::V1::Merchants::ItemsValidator.new
          error_message = {:merchant_id=>["can't be blank", "is not a number"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide an merchant id as a letter string' do
        it 'returns an invalid object' do
          find_params = { merchant_id: 'my_item_id' }
          validator = Api::V1::Merchants::ItemsValidator.new(find_params)
          error_message = {:merchant_id=>["is not a number"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide an merchant id as a number/letter string' do
        it 'returns an invalid object' do

        find_params = { merchant_id: 'item_id_5' }
        validator = Api::V1::Merchants::ItemsValidator.new(find_params)
        error_message = {:merchant_id=>["is not a number"]}

        expect(validator).not_to be_valid
        expect(validator.errors.messages).to eq(error_message)
        end
      end
    end
  end
end
