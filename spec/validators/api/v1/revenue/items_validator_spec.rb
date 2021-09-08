require 'rails_helper'

describe Api::V1::Revenue::ItemsValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide a quantity string' do
        it 'creates a valid object' do
          find_params = { quantity: '10' }
          validator = Api::V1::Revenue::ItemsValidator.new(find_params)

          expect(validator).to be_valid
        end
      end

      context 'when I provide an quantity integer' do
        it 'creates a valid object' do
          find_params = { quantity: 10 }
          validator = Api::V1::Revenue::ItemsValidator.new(find_params)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide a quantity' do
        it 'returns an invalid object' do
          validator = Api::V1::Revenue::ItemsValidator.new
          error_message = {:quantity=>["can't be blank"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a quantity as a letter string' do
        it 'returns an invalid object' do
          find_params = { quantity: 'some-quantity' }
          validator = Api::V1::Revenue::ItemsValidator.new(find_params)
          error_message = {:quantity=>["is not a number"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end

      context 'when I provide a quantity as a number/letter string' do
        it 'returns an invalid object' do

        find_params = { quantity: 'some-quantity-5' }
        validator = Api::V1::Revenue::ItemsValidator.new(find_params)
        error_message = {:quantity=>["is not a number"]}

        expect(validator).not_to be_valid
        expect(validator.errors.messages).to eq(error_message)
        end
      end
    end
  end
end
