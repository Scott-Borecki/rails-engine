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
  end

  describe 'factories' do
    describe 'merchant' do
      it 'is valid with valid attributes' do
        merchant = create(:merchant)
        expect(merchant).to be_valid
      end
    end

    describe 'factory methods' do
      shared_examples 'creates valid objects' do
        it 'creates valid objects' do
          expect(merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(merchant.invoices.first).to be_valid
          expect(merchant.invoices.uniq.size).to eq(1)
          expect(Invoice.all.size).to eq(1)

          merchant.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(merchant.items.first).to be_valid
          expect(Item.all.size).to eq(1)

          expect(merchant.invoices.first.transactions.first).to be_valid
          expect(merchant.invoices.first.transactions.size).to eq(1)
          expect(Transaction.all.size).to eq(1)
        end
      end

      describe '#merchant_with_revenue' do
        context 'when I do not provide arguments' do
          let(:merchant) { merchant_with_revenue }

          include_examples 'creates valid objects'

          it 'applies the default values' do
            expect(merchant.invoices.first.status).to eq('shipped')
            expect(merchant.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(merchant.invoices.first.transactions.first.result).to eq('success')
          end
        end

        context 'when I provide an invoice item count' do
          let(:merchant) { merchant_with_revenue(ii_count: 8) }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice item count' do
            expect(merchant.invoices.first.status).to eq('shipped')
            expect(merchant.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)
            expect(merchant.invoices.first.transactions.first.result).to eq('success')
          end
        end
      end

      describe '#merchant_without_revenue' do
        context 'when I do not provide arguments' do
          let(:merchant) { merchant_without_revenue }

          include_examples 'creates valid objects'

          it 'applies the default values' do
            expect(merchant.invoices.first.status).to eq('packaged')
            expect(merchant.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(merchant.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide an invoice item count' do
          let(:merchant) { merchant_without_revenue(ii_count: 8) }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice item count' do
            expect(merchant.invoices.first.status).to eq('packaged')
            expect(merchant.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)
            expect(merchant.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide an invoice status' do
          let(:merchant) { merchant_without_revenue(status: 'returned') }

          include_examples 'creates valid objects'

          it 'applies the default values except for invoice status' do
            expect(merchant.invoices.first.status).to eq('returned')
            expect(merchant.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(merchant.invoices.first.transactions.first.result).to eq('failed')
          end
        end

        context 'when I provide a transaction result' do
          let(:merchant) { merchant_without_revenue(result: 'refunded') }

          include_examples 'creates valid objects'

          it 'applies the default values except for transaction result' do
            expect(merchant.invoices.first.status).to eq('packaged')
            expect(merchant.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(merchant.invoices.first.transactions.first.result).to eq('refunded')
          end
        end

        context 'when I provide a "shipped" status and "success" transaction result' do
          let(:merchant) { merchant_without_revenue(status: 'shipped', result: 'success') }

          include_examples 'creates valid objects'

          # NOTE: In order for the Item to have revenue, it needs an Invoice
          #       status of 'shipped' and a Transaction result of 'success'.
          #       The method should not allow the two attributes to co-exist.
          it 'applies the default values except for invoice status' do
            expect(merchant.invoices.first.status).to eq('shipped')
            expect(merchant.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)
            expect(merchant.invoices.first.transactions.first.result).not_to eq('success')
          end
        end
      end

      describe '#merchants_with_revenue' do
        context 'when I do not provide a quantity' do
          it 'returns the default quantity of valid merchants' do
            expect { merchants_with_revenue }.to change(Merchant, :count).by(20)
            expect(Merchant.all).to all(be_valid)
          end
        end

        context 'when I provide a quantity' do
          it 'returns the quantity of valid merchants' do
            expect { merchants_with_revenue(10) }.to change(Merchant, :count).by(10)
            expect(Merchant.all).to all(be_valid)
          end
        end
      end
    end

    describe '#merchants_with_random_revenue' do
      context 'when I do not provide a quantity' do
        it 'returns the default quantity of valid merchants' do
          expect { merchants_with_random_revenue }.to change(Merchant, :count).by(20)
          expect(Merchant.all).to all(be_valid)

          Merchant.all.each do |merchant|
            expect(merchant.invoice_items.size).to be <= 10
            expect(merchant.invoice_items.size).to be >= 1
          end
        end
      end

      context 'when I provide a quantity' do
        it 'returns the quantity of valid merchants' do
          expect { merchants_with_random_revenue(10) }.to change(Merchant, :count).by(10)
          expect(Merchant.all).to all(be_valid)

          Merchant.all.each do |merchant|
            expect(merchant.invoice_items.size).to be <= 10
            expect(merchant.invoice_items.size).to be >= 1
          end
        end
      end
    end

    describe '#merchants_without_revenue' do
      context 'when I do not provide a quantity' do
        it 'returns the default quantity of valid merchants' do
          expect { merchants_without_revenue }.to change(Merchant, :count).by(20)
          expect(Merchant.all).to all(be_valid)
        end
      end

      context 'when I provide a quantity' do
        it 'returns the quantity of valid merchants' do
          expect { merchants_without_revenue(10) }.to change(Merchant, :count).by(10)
          expect(Merchant.all).to all(be_valid)
        end
      end
    end
  end
end
