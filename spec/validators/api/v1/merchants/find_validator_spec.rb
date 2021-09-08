require 'rails_helper'

describe Api::V1::Merchants::FindValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do

      context 'when I provide a name' do
        it 'creates a valid object' do
          find_params = { name: 'name' }
          validator = Api::V1::Merchants::FindValidator.new(find_params)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide any parameters' do
        it 'returns an invalid object' do
          validator = Api::V1::Merchants::FindValidator.new
          error_message = {:name=>["can't be blank"]}

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq(error_message)
        end
      end
    end
  end
end
