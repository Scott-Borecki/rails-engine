require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      merchant = create(:merchant)
      expect(merchant).to be_valid
    end
  end
end
