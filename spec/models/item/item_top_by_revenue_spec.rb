require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '.top_by_revenue' do
    context 'when I provide a quantity' do
      # See /spec/factories/items.rb for:
      #   - item_with_revenue
      #   - item_without_revenue
      let!(:item1) { item_with_revenue(invoice_items_count: 1) }
      let!(:item2) { item_with_revenue(invoice_items_count: 6) }
      let!(:item3) { item_with_revenue(invoice_items_count: 4) }
      let!(:item4) { item_with_revenue(invoice_items_count: 5) }
      let!(:item5) { item_with_revenue(invoice_items_count: 3) }
      let!(:item6) { item_with_revenue(invoice_items_count: 2) }
      let!(:item7) { item_without_revenue(invoice_items_count: 7) }
      let!(:item8) { item_without_revenue(invoice_items_count: 8) }

      let(:top_six_by_revenue) { [item2, item4, item3, item5, item6, item1] }
      let(:top_three_by_revenue) { [item2, item4, item3] }

      it 'returns the top items by revenue', :aggregate_failures do
        actual = Item.top_by_revenue(6)
        expect(actual.length).to eq(6)
        expect(actual).to eq(top_six_by_revenue)

        actual = Item.top_by_revenue(3)
        expect(actual.length).to eq(3)
        expect(actual).to eq(top_three_by_revenue)
      end
    end

    context 'when I do not provide a quantity' do
      it 'returns a default of ten items by revenue', :aggregate_failures do
        # See /spec/factories/items.rb for #items_with_random_revenue
        items_with_random_revenue(15)

        actual = Item.top_by_revenue
        expect(actual.length).to eq(10)

        comparison = actual.first.total_revenue > actual.last.total_revenue
        expect(comparison).to be true
      end
    end
  end
end
