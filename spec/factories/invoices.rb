FactoryBot.define do
  factory :invoice do
    status { %w[shipped packaged returned].sample }
    customer
    merchant
  end
end

# Internal: Creates an Invoice object WITH revenue to DRY up test setup for
# tracking revenue. In order for the Invoice object to have revenue, Invoice
# status must be 'shipped' and the Transaction result must be 'success'. The
# following associated objects are created:
#   - an Invoice (with a 'shipped' status),
#   - an Item (with an anonymous Merchant),
#   - a Transaction (with a 'success' result), and
#   - a list of InvoiceItems (with a quantity of 1 and unit_price of 1.50).
#
# ii_count - The Integer quantity of InvoiceItem objects to create (Default: 4)
#
# Examples
#
#   invoice = invoice_with_revenue
#   invoice.total_revenue_generated
#   # => 6
#
#   invoice = invoice_with_revenue(ii_count: 11)
#   invoice.total_revenue_generated
#   # => 16.5
#
# Returns the Invoice object created.
def invoice_with_revenue(ii_count: 4)
  FactoryBot.create(:invoice, status: 'shipped') do |invoice|
    FactoryBot.create(:item, merchant: invoice.merchant) do |item|
      FactoryBot.create(:transaction, result: 'success', invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end

# Internal: Creates an Invoice object WITHOUT revenue to DRY up test setup for
# tracking revenue. In order for the Invoice object to have revenue, the Invoice
# status must be 'shipped' and the Transaction result must be 'success'.
# Therefore, this method will not allow the user to create an invoice with those
# statuses. The following associated objects are created:
#   - an Invoice (with a default 'packaged' status),
#   - an Item (with an anonymous Merchant),
#   - a Transaction (with a default 'failed' result), and
#   - a list of InvoiceItems (with a quantity of 1 and unit_price of 1.50).
#
# ii_count - The Integer quantity of InvoiceItem objects to create (Default: 4)
# status   - The String status of the Invoice object (Default: 'packaged')
# result   - The String result of the Transaction object (Default: 'failed')
#
# Examples
#
#   invoice = invoice_without_revenue
#   invoice.total_revenue_generated
#   # => 0
#
#   invoice = invoice_without_revenue(ii_count: 8)
#   invoice.total_revenue_generated
#   # => 0
#
# Returns the Invoice object created.
def invoice_without_revenue(ii_count: 4, status: 'packaged', result: 'failed')
  result = %w[failed refunded].sample if status == 'shipped'
  FactoryBot.create(:invoice, status: status) do |invoice|
    FactoryBot.create(:item, merchant: invoice.merchant) do |item|
      FactoryBot.create(:transaction, result: result, invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end
