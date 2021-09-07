require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '.top_by_items_sold' do
    # See /spec/factories/merchants.rb for:
    #   #merchant_with_revenue
    #   #merchant_without_revenue
    #
    let!(:merchant1) { merchant_with_revenue(invoice_items_count: 1) }
    let!(:merchant2) { merchant_with_revenue(invoice_items_count: 6) }
    let!(:merchant3) { merchant_with_revenue(invoice_items_count: 4) }
    let!(:merchant4) { merchant_with_revenue(invoice_items_count: 5) }
    let!(:merchant5) { merchant_with_revenue(invoice_items_count: 3) }
    let!(:merchant6) { merchant_with_revenue(invoice_items_count: 2) }
    let!(:merchant7) { merchant_without_revenue(invoice_items_count: 7) }
    let!(:merchant8) { merchant_without_revenue(invoice_items_count: 8) }

    let(:top_five_by_items_sold) { [merchant2, merchant4, merchant3, merchant5, merchant6] }
    let(:top_three_by_items_sold) { [merchant2, merchant4, merchant3] }

    it 'returns the top merchants by items sold', :aggregate_failures do
      actual = Merchant.top_by_items_sold
      expect(actual.length).to eq(5)
      expect(actual).to eq(top_five_by_items_sold)

      actual = Merchant.top_by_items_sold(3)
      expect(actual.length).to eq(3)
      expect(actual).to eq(top_three_by_items_sold)
    end
  end
end
