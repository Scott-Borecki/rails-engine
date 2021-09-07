require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe '.considered_as_revenue' do
    let!(:invoice1) { invoice_without_revenue(status: 'packaged', result: 'success') }
    let!(:invoice2) { invoice_with_revenue(status: 'shipped', result: 'success') }
    let!(:invoice3) { invoice_with_revenue(status: 'shipped', result: 'success') }
    let!(:invoice4) { invoice_without_revenue(status: 'returned', result: 'refunded') }
    let!(:invoice5) { invoice_without_revenue(status: 'shipped', result: 'failed') }

    it 'returns the invoices that are considered as revenue' do
      expect(Invoice.considered_as_revenue).to eq([invoice2, invoice3])
    end
  end
end
