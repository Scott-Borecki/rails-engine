require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      invoice = create(:invoice)
      expect(invoice).to be_valid
    end
  end
end
