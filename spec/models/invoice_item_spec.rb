require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      invoice_item = create(:invoice_item)
      expect(invoice_item).to be_valid
    end
  end
end
