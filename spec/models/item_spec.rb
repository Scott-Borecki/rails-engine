require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'delegations' do
    it { should delegate_method(:total_revenue_generated).to(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'factories' do
    describe 'item' do
      it 'is valid with valid attributes' do
        item = create(:item)
        expect(item).to be_valid
      end
    end

    describe '#item_with_revenue' do
      context 'when I do not provide arguments' do
        it 'creates a valid item' do
          item = item_with_revenue

          expect(item).to be_valid
          expect(Item.all.size).to eq(1)

          expect(item.invoices.first).to be_valid
          expect(item.invoices.uniq.size).to eq(1)
          expect(Invoice.all.size).to eq(1)
          expect(item.invoices.first.status).to eq('shipped')

          expect(item.invoice_items.size).to eq(4)
          expect(InvoiceItem.all.size).to eq(4)

          item.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(item.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(item.invoices.first.transactions.first).to be_valid
          expect(item.invoices.first.transactions.size).to eq(1)
          expect(item.invoices.first.transactions.first.result).to eq('success')
          expect(Transaction.all.size).to eq(1)
        end
      end

      context 'when I provide an invoice item count' do
        it 'creates a valid item' do
          item = item_with_revenue(ii_count: 8)

          expect(item).to be_valid
          expect(Item.all.size).to eq(1)

          expect(item.invoices.first).to be_valid
          expect(item.invoices.uniq.size).to eq(1)
          expect(Invoice.all.size).to eq(1)
          expect(item.invoices.first.status).to eq('shipped')

          expect(item.invoice_items.size).to eq(8)
          expect(InvoiceItem.all.size).to eq(8)

          item.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(item.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(item.invoices.first.transactions.first).to be_valid
          expect(item.invoices.first.transactions.size).to eq(1)
          expect(item.invoices.first.transactions.first.result).to eq('success')
          expect(Transaction.all.size).to eq(1)
        end
      end
    end

    describe '#item_without_revenue' do
      context 'when I do not provide arguments' do
        it 'creates a valid item' do
          item = item_without_revenue

          expect(item).to be_valid
          expect(Item.all.size).to eq(1)

          expect(item.invoices.first).to be_valid
          expect(item.invoices.uniq.size).to eq(1)
          expect(Invoice.all.size).to eq(1)
          expect(item.invoices.first.status).to eq('packaged')

          expect(item.invoice_items.size).to eq(4)
          expect(InvoiceItem.all.size).to eq(4)

          item.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(item.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(item.invoices.first.transactions.first).to be_valid
          expect(item.invoices.first.transactions.size).to eq(1)
          expect(item.invoices.first.transactions.first.result).to eq('failed')
          expect(Transaction.all.size).to eq(1)
        end

        context 'when I provide an invoice item count' do
          it 'creates a valid item' do
            item = item_without_revenue(ii_count: 8)

            expect(item).to be_valid
            expect(Item.all.size).to eq(1)

            expect(item.invoices.first).to be_valid
            expect(item.invoices.uniq.size).to eq(1)
            expect(Invoice.all.size).to eq(1)
            expect(item.invoices.first.status).to eq('packaged')

            expect(item.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)

            item.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(item.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(item.invoices.first.transactions.first).to be_valid
            expect(item.invoices.first.transactions.size).to eq(1)
            expect(item.invoices.first.transactions.first.result).to eq('failed')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide an invoice status' do
          it 'creates a valid item' do
            item = item_without_revenue(status: 'returned')

            expect(item).to be_valid
            expect(Item.all.size).to eq(1)

            expect(item.invoices.first).to be_valid
            expect(item.invoices.uniq.size).to eq(1)
            expect(Invoice.all.size).to eq(1)
            expect(item.invoices.first.status).to eq('returned')

            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            item.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(item.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(item.invoices.first.transactions.first).to be_valid
            expect(item.invoices.first.transactions.size).to eq(1)
            expect(item.invoices.first.transactions.first.result).to eq('failed')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide a transaction result' do
          it 'creates a valid item' do
            item = item_without_revenue(result: 'refunded')

            expect(item).to be_valid
            expect(Item.all.size).to eq(1)

            expect(item.invoices.first).to be_valid
            expect(item.invoices.uniq.size).to eq(1)
            expect(Invoice.all.size).to eq(1)
            expect(item.invoices.first.status).to eq('packaged')

            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            item.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(item.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(item.invoices.first.transactions.first).to be_valid
            expect(item.invoices.first.transactions.size).to eq(1)
            expect(item.invoices.first.transactions.first.result).to eq('refunded')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide a "shipped" status and "success" transaction result' do
          # NOTE: In order for the Item to have revenue, it needs an Invoice
          #       status of 'shipped' and a Transaction result of 'success'.
          #       The method should not allow the two attributes to co-exist.
          it 'creates a valid item and changes transaction result from "success"' do
            item = item_without_revenue(status: 'shipped', result: 'success')

            expect(item).to be_valid
            expect(Item.all.size).to eq(1)

            expect(item.invoices.first).to be_valid
            expect(item.invoices.uniq.size).to eq(1)
            expect(Invoice.all.size).to eq(1)
            expect(item.invoices.first.status).to eq('shipped')

            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            item.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(item.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(item.invoices.first.transactions.first).to be_valid
            expect(item.invoices.first.transactions.size).to eq(1)
            expect(item.invoices.first.transactions.first.result).not_to eq('success')
            expect(Transaction.all.size).to eq(1)
          end
        end
      end
    end

    describe '#items_with_random_revenue' do
      context 'when I do not provide a quantity' do
        it 'returns the default quantity of valid items' do
          expect(Item.all.size).to eq(0)

          items_with_random_revenue
          items = Item.all

          expect(items.size).to eq(20)

          items.each do |item|
            expect(item).to be_valid
            expect(item.invoice_items.size).to be <= 10
            expect(item.invoice_items.size).to be >= 1
          end
        end
      end

      context 'when I provide a quantity' do
        it 'returns the quantity of valid items' do
          expect(Item.all.size).to eq(0)

          items_with_random_revenue(10)
          items = Item.all

          expect(items.size).to eq(10)

          items.each do |item|
            expect(item).to be_valid
            expect(item.invoice_items.size).to be <= 10
            expect(item.invoice_items.size).to be >= 1
          end
        end
      end
    end
  end
end
