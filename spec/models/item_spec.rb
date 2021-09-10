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

    describe 'factory methods' do
      shared_examples 'creates valid objects' do
        it 'creates valid objects' do
          expect(item).to be_valid
          expect(Item.all.size).to eq(1)

          expect(item.invoices.first).to be_valid
          expect(item.invoices.uniq.size).to eq(1)
          expect(Invoice.all.size).to eq(1)

          item.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(item.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(item.invoices.first.transactions.first).to be_valid
          expect(item.invoices.first.transactions.size).to eq(1)
          expect(Transaction.all.size).to eq(1)
        end
      end

      describe '#item_with_revenue' do
        context 'when I do not provide arguments' do
          let(:item) { item_with_revenue }

          include_examples 'creates valid objects'

          it 'applies the default values' do
            expect(item.invoices.first.status).to eq('shipped')
            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(item.invoices.first.transactions.first.result).to eq('success')
          end
        end

        context 'when I provide an invoice item count' do
          let(:item) { item_with_revenue(ii_count: 8) }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice item count' do
            expect(item.invoices.first.status).to eq('shipped')
            expect(item.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)
            expect(item.invoices.first.transactions.first.result).to eq('success')
          end
        end
      end

      describe '#item_without_revenue' do
        context 'when I do not provide arguments' do
          let(:item) { item_without_revenue }

          include_examples 'creates valid objects'

          it 'applies the default values' do
            expect(item.invoices.first.status).to eq('packaged')
            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(item.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide an invoice item count' do
          let(:item) { item_without_revenue(ii_count: 8) }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice item count' do
            expect(item.invoices.first.status).to eq('packaged')
            expect(item.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)
            expect(item.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide an invoice status' do
          let(:item) { item_without_revenue(status: 'returned') }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice status' do
            expect(item.invoices.first.status).to eq('returned')
            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(item.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide a transaction result' do
          let(:item) { item_without_revenue(result: 'refunded') }

          include_examples 'creates valid objects'

          it 'applies the default values except for transaction result' do
            expect(item.invoices.first.status).to eq('packaged')
            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(item.invoices.first.transactions.first.result).to eq('refunded')
          end
        end

        context 'when I provide a "shipped" status and "success" transaction result' do
          let(:item) { item_without_revenue(status: 'shipped', result: 'success') }

          include_examples 'creates valid objects'

          # NOTE: In order for the Item to have revenue, it needs an Invoice
          #       status of 'shipped' and a Transaction result of 'success'.
          #       The method should not allow the two attributes to co-exist.
          it 'applies the default values except for invoice status' do
            expect(item.invoices.first.status).to eq('shipped')
            expect(item.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(item.invoices.first.transactions.first.result).not_to eq('success')
          end
        end
      end

      describe '#items_with_random_revenue' do
        context 'when I do not provide a quantity' do
          it 'returns the default quantity of valid items' do
            expect { items_with_random_revenue(20) }.to change(Item, :count).by(20)
            expect(Item.all).to all(be_valid)

            Item.all.each do |item|
              expect(item.invoice_items.size).to be <= 10
              expect(item.invoice_items.size).to be >= 1
            end
          end
        end

        context 'when I provide a quantity' do
          it 'returns the quantity of valid items' do
            expect { items_with_random_revenue(10) }.to change(Item, :count).by(10)
            expect(Item.all).to all(be_valid)

            Item.all.each do |item|
              expect(item.invoice_items.size).to be <= 10
              expect(item.invoice_items.size).to be >= 1
            end
          end
        end
      end
    end
  end
end
