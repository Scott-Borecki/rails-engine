require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'factories' do
    describe 'invoice_item' do
      it 'is valid with valid attributes' do
        invoice_item = create(:invoice_item)
        expect(invoice_item).to be_valid
      end
    end

    describe 'invoice_item_fixed' do
      it 'is valid with valid attributes' do
        invoice_item = create(:invoice_item_fixed)
        expect(invoice_item).to be_valid
        expect(invoice_item.quantity).to eq(1)
        expect(invoice_item.unit_price).to eq(1.5)
      end
    end
  end
end
