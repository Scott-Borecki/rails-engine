require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[shipped packaged returned]) }
  end

  describe 'factories' do
    describe 'invoice' do
      it 'is valid with valid attributes' do
        invoice = create(:invoice)
        expect(invoice).to be_valid
      end
    end

    describe '#invoice_with_revenue' do
      context 'when I do not provide arguments' do
        it 'creates a valid invoice' do
          invoice = invoice_with_revenue

          expect(invoice).to be_valid
          expect(invoice.status).to eq('shipped')

          expect(invoice.invoice_items.size).to eq(4)
          expect(InvoiceItem.all.size).to eq(4)

          invoice.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(invoice.items.first).to be_valid
          expect(invoice.items.uniq.size).to eq(1)
          expect(Item.all.size).to eq(1)

          expect(invoice.items.first.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(invoice.transactions.first).to be_valid
          expect(invoice.transactions.size).to eq(1)
          expect(invoice.transactions.first.result).to eq('success')
          expect(Transaction.all.size).to eq(1)
        end
      end

      context 'when I provide an invoice item count' do
        it 'creates a valid invoice' do
          invoice = invoice_with_revenue(ii_count: 8)

          expect(invoice).to be_valid
          expect(invoice.status).to eq('shipped')

          expect(invoice.invoice_items.size).to eq(8)
          expect(InvoiceItem.all.size).to eq(8)

          invoice.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(invoice.items.first).to be_valid
          expect(invoice.items.uniq.size).to eq(1)
          expect(Item.all.size).to eq(1)

          expect(invoice.items.first.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(invoice.transactions.first).to be_valid
          expect(invoice.transactions.size).to eq(1)
          expect(invoice.transactions.first.result).to eq('success')
          expect(Transaction.all.size).to eq(1)
        end
      end
    end

    describe '#invoice_without_revenue' do
      context 'when I do not provide arguments' do
        it 'creates a valid invoice' do
          invoice = invoice_without_revenue

          expect(invoice).to be_valid
          expect(invoice.status).to eq('packaged')

          expect(invoice.invoice_items.size).to eq(4)
          expect(InvoiceItem.all.size).to eq(4)

          invoice.invoice_items.each do |invoice_item|
            expect(invoice_item).to be_valid
            expect(invoice_item.quantity).to eq(1)
            expect(invoice_item.unit_price).to eq(1.50)
          end

          expect(invoice.items.first).to be_valid
          expect(invoice.items.uniq.size).to eq(1)
          expect(Item.all.size).to eq(1)

          expect(invoice.items.first.merchant).to be_valid
          expect(Merchant.all.size).to eq(1)

          expect(invoice.transactions.first).to be_valid
          expect(invoice.transactions.size).to eq(1)
          expect(invoice.transactions.first.result).to eq('failed')
          expect(Transaction.all.size).to eq(1)
        end

        context 'when I provide an invoice item count' do
          it 'creates a valid invoice' do
            invoice = invoice_without_revenue(ii_count: 8)

            expect(invoice).to be_valid
            expect(invoice.status).to eq('packaged')
            expect(Invoice.all.size).to eq(1)

            expect(invoice.invoice_items.size).to eq(8)
            expect(InvoiceItem.all.size).to eq(8)

            invoice.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(invoice.items.first).to be_valid
            expect(invoice.items.uniq.size).to eq(1)
            expect(Item.all.size).to eq(1)

            expect(invoice.items.first.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(invoice.transactions.first).to be_valid
            expect(invoice.transactions.size).to eq(1)
            expect(invoice.transactions.first.result).to eq('failed')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide an invoice status' do
          it 'creates a valid invoice' do
            invoice = invoice_without_revenue(status: 'returned')

            expect(invoice).to be_valid
            expect(invoice.status).to eq('returned')
            expect(Invoice.all.size).to eq(1)

            expect(invoice.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            invoice.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(invoice.items.first).to be_valid
            expect(invoice.items.uniq.size).to eq(1)
            expect(Item.all.size).to eq(1)

            expect(invoice.items.first.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(invoice.transactions.first).to be_valid
            expect(invoice.transactions.size).to eq(1)
            expect(invoice.transactions.first.result).to eq('failed')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide a transaction result' do
          it 'creates a valid invoice' do
            invoice = invoice_without_revenue(result: 'refunded')

            expect(invoice).to be_valid
            expect(invoice.status).to eq('packaged')
            expect(Invoice.all.size).to eq(1)

            expect(invoice.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            invoice.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(invoice.items.first).to be_valid
            expect(invoice.items.uniq.size).to eq(1)
            expect(Item.all.size).to eq(1)

            expect(invoice.items.first.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(invoice.transactions.first).to be_valid
            expect(invoice.transactions.size).to eq(1)
            expect(invoice.transactions.first.result).to eq('refunded')
            expect(Transaction.all.size).to eq(1)
          end
        end

        context 'when I provide a "shipped" status and "success" transaction result' do
          # NOTE: In order for the Invoice to have revenue, it needs an Invoice
          #       status of 'shipped' and a Transaction result of 'success'.
          #       The method should not allow the two attributes to co-exist.
          it 'creates a valid invoice and changes transaction result from "success"' do
            invoice = invoice_without_revenue(status: 'shipped', result: 'success')

            expect(invoice).to be_valid
            expect(invoice.status).to eq('shipped')
            expect(Invoice.all.size).to eq(1)

            expect(invoice.invoice_items.size).to eq(4)
            expect(InvoiceItem.all.size).to eq(4)

            invoice.invoice_items.each do |invoice_item|
              expect(invoice_item).to be_valid
              expect(invoice_item.quantity).to eq(1)
              expect(invoice_item.unit_price).to eq(1.50)
            end

            expect(invoice.items.first).to be_valid
            expect(invoice.items.uniq.size).to eq(1)
            expect(Item.all.size).to eq(1)

            expect(invoice.items.first.merchant).to be_valid
            expect(Merchant.all.size).to eq(1)

            expect(invoice.transactions.first).to be_valid
            expect(invoice.transactions.size).to eq(1)
            expect(invoice.transactions.first.result).not_to eq('success')
            expect(Transaction.all.size).to eq(1)
          end
        end
      end
    end
  end
end
