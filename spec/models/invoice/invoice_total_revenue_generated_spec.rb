require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe '.total_revenue_generated' do
    # See /spec/factories/invoice.rb for:
    #   - invoice_with_revenue
    #   - invoice_without_revenue
    let!(:invoice1) { invoice_without_revenue(status: 'packaged', result: 'success') }
    let!(:invoice2) { invoice_with_revenue(ii_count: 2) }
    let!(:invoice3) { invoice_with_revenue(ii_count: 3) }
    let!(:invoice4) { invoice_without_revenue(status: 'returned', result: 'refunded') }
    let!(:invoice5) { invoice_without_revenue(status: 'shipped', result: 'failed') }

    it 'returns the revenue generated by the invoices' do
      expect(Invoice.total_revenue_generated).to eq(7.50)
    end
  end
end
