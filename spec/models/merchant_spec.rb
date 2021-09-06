require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices).dependent(:destroy) }
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'delegations' do
    it { should delegate_method(:total_revenue_generated).to(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      merchant = create(:merchant)
      expect(merchant).to be_valid
    end
  end

  describe 'class methods' do
    let!(:merchant1) { create(:merchant, name: 'BaA') } # Asc Order: 2
    let!(:merchant2) { create(:merchant, name: 'bac') } # Asc Order: 5
    let!(:merchant3) { create(:merchant, name: 'bAA') } # Asc Order: 4
    let!(:merchant4) { create(:merchant, name: 'Bab') } # Asc Order: 3
    let!(:merchant5) { create(:merchant, name: 'BAa') } # Asc Order: 1

    describe '.order_by_name' do
      let(:asc) { [merchant5, merchant1, merchant4, merchant3, merchant2] }
      let(:desc) { [merchant2, merchant3, merchant4, merchant1, merchant5] }

      context 'when I do not provide any parameters' do
        it 'orders the merchants by name (case-sensitive) in ascending order (default)' do
          expect(Merchant.order_by_name).to eq(asc)
        end
      end

      context 'when I provide a parameter "desc"' do
        it 'orders the merchants by name (case-sensitive) in descending order' do
          expect(Merchant.order_by_name('desc')).to eq(desc)
        end
      end

      context 'when I provide a parameter other than "desc"' do
        it 'orders the merchants by name (case-sensitive) in ascending order (default)', :aggregate_failures do
          expect(Merchant.order_by_name(123)).to eq(asc)
          expect(Merchant.order_by_name('des')).to eq(asc)
        end
      end
    end

    describe '.find_all_by_name' do
      let(:merchants_aa) { [merchant5, merchant1, merchant3] }

      context 'when I provide a valid search string' do
        context 'when there are merchants with a partial match' do
          it 'returns the first merchant with partial match in case-sensitive alphabetical order' do
            expect(Merchant.find_all_by_name('aA')).to eq(merchants_aa)
          end
        end

        context 'when there are no merchants with a partial match' do
          it 'returns an empty array' do
            expect(Merchant.find_all_by_name('cccc')).to eq([])
          end
        end
      end

      context 'when I do not provide a valid search string' do
        it 'returns nil' do
          expect(Merchant.find_all_by_name).to be_nil
        end
      end
    end

    describe '.top_by_items_sold' do
      it 'returns the top merchants by items sold' do
        # See /spec/factories/merchants.rb for #merchant_with_revenue
        merchant_with_revenue(invoice_items_count: 1) # merchant1
        merchant2 = merchant_with_revenue(invoice_items_count: 6)
        merchant3 = merchant_with_revenue(invoice_items_count: 4)
        merchant4 = merchant_with_revenue(invoice_items_count: 5)
        merchant5 = merchant_with_revenue(invoice_items_count: 3)
        merchant6 = merchant_with_revenue(invoice_items_count: 2)
        # See /spec/factories/merchants.rb for #merchant_without_revenue
        merchant_without_revenue(invoice_items_count: 7) # merchant7
        merchant_without_revenue(invoice_items_count: 8) # merchant8

        top_five_by_items_sold = [merchant2, merchant4, merchant3, merchant5, merchant6]
        top_three_by_items_sold = [merchant2, merchant4, merchant3]

        actual = Merchant.top_by_items_sold
        expect(actual.length).to eq(5)
        expect(actual).to eq(top_five_by_items_sold)

        actual = Merchant.top_by_items_sold(3)
        expect(actual.length).to eq(3)
        expect(actual).to eq(top_three_by_items_sold)
      end
    end

    describe '.top_by_revenue' do
      it 'returns the top merchants by revenue', :aggregate_failures do
        # See /spec/factories/merchants.rb for #merchant_with_revenue
        merchant1 = merchant_with_revenue(invoice_items_count: 1)
        merchant2 = merchant_with_revenue(invoice_items_count: 6)
        merchant3 = merchant_with_revenue(invoice_items_count: 4)
        merchant4 = merchant_with_revenue(invoice_items_count: 5)
        merchant5 = merchant_with_revenue(invoice_items_count: 3)
        merchant6 = merchant_with_revenue(invoice_items_count: 2)
        # See /spec/factories/merchants.rb for #merchant_without_revenue
        merchant_without_revenue(invoice_items_count: 7) # merchant7
        merchant_without_revenue(invoice_items_count: 8) # merchant8

        top_six_by_revenue = [merchant2, merchant4, merchant3, merchant5, merchant6, merchant1]
        top_three_by_revenue = [merchant2, merchant4, merchant3]

        actual = Merchant.top_by_revenue(6)
        expect(actual.length).to eq(6)
        expect(actual).to eq(top_six_by_revenue)

        actual = Merchant.top_by_revenue(3)
        expect(actual.length).to eq(3)
        expect(actual).to eq(top_three_by_revenue)
      end
    end
  end
end
