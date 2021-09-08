require 'rails_helper'

describe Api::V1::Items::FindValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide a name' do
        it 'creates a valid object' do
          find_params = { name: 'name' }
          validator = Api::V1::Items::FindValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide a min price' do
        it 'creates a valid object' do
          find_params = { min_price: '10' }
          validator = Api::V1::Items::FindValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide a max price' do
        it 'creates a valid object' do
          find_params = { max_price: '10' }
          validator = Api::V1::Items::FindValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide a min price and max price' do
        it 'creates a valid object' do
          find_params = { min_price: '5', max_price: '10' }
          validator = Api::V1::Items::FindValidator.new(find_params)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide any parameters' do
        it 'does not create a valid object' do
          validator = Api::V1::Items::FindValidator.new
          error_message = {:query=>['query must be provided with a value']}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a name and max price' do
        it 'returns an invalid object' do
          find_params = { name: 'name', max_price: '5' }
          validator = Api::V1::Items::FindValidator.new(find_params)
          error_message = {:name=>["cannot be queried with price"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a name and min price' do
        it 'returns an invalid object' do

        find_params = { name: 'name', min_price: '5' }
        validator = Api::V1::Items::FindValidator.new(find_params)
        error_message = {:name=>["cannot be queried with price"]}

        expect(validator).not_to be_valid
        expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a name, min price, and max price' do
        it 'returns an invalid object' do
          find_params = { name: 'name', min_price: '5', max_price: '10' }
          validator = Api::V1::Items::FindValidator.new(find_params)
          error_message = {:name=>["cannot be queried with price"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a max price less than the min price' do
        it 'returns an invalid object' do
          find_params = { min_price: '10', max_price: '5' }
          validator = Api::V1::Items::FindValidator.new(find_params)
          error_message = {:price=>["max price must be greater than min price"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end
    end
  end
end
