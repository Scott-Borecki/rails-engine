require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      customer = create(:customer)
      expect(customer).to be_valid
    end
  end
end
