require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      transaction = create(:transaction)
      expect(transaction).to be_valid
    end
  end
end
