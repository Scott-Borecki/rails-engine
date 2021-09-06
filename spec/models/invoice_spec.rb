require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[shipped packaged returned]) }

    it 'is valid with valid attributes' do
      invoice = create(:invoice)
      expect(invoice).to be_valid
    end
  end

  describe 'class methods' do
    describe '.considered_as_revenue' do
      it 'returns the invoices that are considered as revenue' do
        invoice1 = create(:invoice, status: 'packaged') # transaction: success
        invoice2 = create(:invoice, status: 'shipped')  # transaction: success
        invoice3 = create(:invoice, status: 'shipped')  # transaction: success
        invoice4 = create(:invoice, status: 'returned') # transaction: refunded
        invoice5 = create(:invoice, status: 'shipped')  # transaction: failed

        transaction_i1 = create(:transaction, invoice: invoice1, result: 'success')
        transaction_i2 = create(:transaction, invoice: invoice2, result: 'failed')
        transaction_i2 = create(:transaction, invoice: invoice2, result: 'success')
        transaction_i2 = create(:transaction, invoice: invoice2, result: 'refunded')
        transaction_i3 = create(:transaction, invoice: invoice3, result: 'failed')
        transaction_i3 = create(:transaction, invoice: invoice3, result: 'success')
        transaction_i4 = create(:transaction, invoice: invoice4, result: 'failed')
        transaction_i4 = create(:transaction, invoice: invoice4, result: 'failed')
        transaction_i4 = create(:transaction, invoice: invoice4, result: 'success')
        transaction_i4 = create(:transaction, invoice: invoice4, result: 'refunded')
        transaction_i5 = create(:transaction, invoice: invoice5, result: 'failed')

        expect(Invoice.considered_as_revenue).to eq([invoice2, invoice3])
      end
    end
  end
end
