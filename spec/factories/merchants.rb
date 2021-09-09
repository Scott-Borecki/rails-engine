FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end

# Internal: Creates an Merchant object WITHOUT revenue to DRY up test setup for
# tracking revenue. In order for the Merchant object to have revenue, the Invoice
# status must be 'shipped' and the Transaction result must be 'success'. The
# following associated objects are created:
#   - a Merchant,
#   - an Item,
#   - an Invoice (with a 'shipped' status),
#   - a Transaction (with a 'success' result), and
#   - a list of InvoiceItems (with a quantity of 1 and unit_price of 1.50).
#
# ii_count - The Integer quantity of InvoiceItem objects to create (Default: 4)
#
# Examples
#
#   merchant = merchant_with_revenue
#   merchant.total_revenue_generated
#   # => 6
#
#   merchant = merchant_with_revenue(ii_count: 11)
#   item.total_revenue_generated
#   # => 16.5
#
# Returns the Merchant object created.
def merchant_with_revenue(ii_count: 4)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant: merchant) do |item|
      FactoryBot.create(:invoice, merchant: merchant, status: 'shipped') do |invoice|
        FactoryBot.create(:transaction, result: 'success', invoice: invoice)
        FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
      end
    end
  end
end

# Internal: Creates an Merchant object WITHOUT revenue to DRY up test setup for
# tracking revenue. In order for the Merchant object to have revenue, the Invoice
# status must be 'shipped' and the Transaction result must be 'success'.
# Therefore, this method will not allow the user to create an invoice with those
# statuses. The following associated objects are created:
#   - a Merchant,
#   - an Item ,
#   - an Invoice (with a default 'packaged' status),
#   - a Transaction (with a default 'failed' result), and
#   - a list of InvoiceItems (with a quantity of 1 and unit_price of 1.50).
#
# ii_count - The Integer quantity of InvoiceItem objects to create (Default: 4)
# status   - The String status of the Invoice object (Default: 'packaged')
# result   - The String result of the Transaction object (Default: 'failed')
#
# Examples
#
#   merchant = merchant_without_revenue
#   merchant.total_revenue_generated
#   # => 0
#
#   merchant = merchant_without_revenue(ii_count: 8)
#   merchant.total_revenue_generated
#   # => 0
#
# Returns the Merchant object created.
def merchant_without_revenue(ii_count: 4, status: 'packaged', result: 'failed')
  result = %w[failed refunded].sample if status == 'shipped'
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant: merchant) do |item|
      FactoryBot.create(:invoice, merchant: merchant, status: status) do |invoice|
        FactoryBot.create(:transaction, result: result, invoice: invoice)
        FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
      end
    end
  end
end

# Internal: Creates a list of Merchants with revenue.  This method is intended
# to be used for test cases where revenue needs to be evaluated, but
# knowing the order of Merchants by revenue is not needed.  See above for
# #merchant_with_revenue to understand the other objects created.
#
# quantity - The Integer quantity of Merchants to create (Default: 20)
#
# Returns the Integer quantity of Merchants created.
def merchants_with_revenue(quantity = 20)
  quantity.times { merchant_with_revenue }
end

# Internal: Creates a list of Merchants with random revenue.  This method is
# intended to be used for test cases where revenue needs to be evaluated, but
# knowing the total revenue or order of Merchants by revenue is not needed.  See
# above for #merchant_with_revenue to understand the other objects created.
#
# quantity - The Integer quantity of Merchants to create (Default: 20)
#
# Returns the Integer quantity of Merchants created.
def merchants_with_random_revenue(quantity = 20)
  quantity.times { merchant_with_revenue(ii_count: rand(1..10)) }
end

# Internal: Creates a list of Merchants WITHOUT revenue.  This method is
# intended to be used for test cases where revenue needs to be evaluated, but
# knowing the order of Merchants by revenue is not needed.  See above for
# #merchant_without_revenue to understand the other objects created.
#
# quantity - The Integer quantity of Merchants to create (Default: 20)
#
# Returns the Integer quantity of Merchants created.
def merchants_without_revenue(quantity = 20)
  quantity.times { merchant_without_revenue }
end
