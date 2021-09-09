FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::GreekPhilosophers.quote }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant
  end
end

# Internal: Creates an Item object WITHOUT revenue to DRY up test setup for
# tracking revenue. In order for the Item object to have revenue, the Invoice
# status must be 'shipped' and the Transaction result must be 'success'. The
# following associated objects are created:
#   - an Item (with an anonymous Merchant),
#   - an Invoice (with a 'shipped' status),
#   - a Transaction (with a 'success' result), and
#   - a list of InvoiceItems (with a quantity of 1 and unit_price of 1.50).
#
# ii_count - The Integer quantity of InvoiceItem objects to create (Default: 4)
#
# Examples
#
#   item = item_with_revenue
#   item.total_revenue_generated
#   # => 6
#
#   item = item_with_revenue(ii_count: 11)
#   item.total_revenue_generated
#   # => 16.5
#
# Returns the Item object created.
def item_with_revenue(ii_count: 4)
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant: item.merchant, status: 'shipped') do |invoice|
      FactoryBot.create(:transaction, result: 'success', invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end

# Internal: Creates an Item object WITHOUT revenue to DRY up test setup for
# tracking revenue. In order for the Item object to have revenue, the Invoice
# status must be 'shipped' and the Transaction result must be 'success'.
# Therefore, this method will not allow the user to create an invoice with those
# statuses. The following associated objects are created:
#   - an Item (with an anonymous Merchant),
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
#   item = item_without_revenue
#   item.total_revenue_generated
#   # => 0
#
#   item = item_without_revenue(ii_count: 8)
#   item.total_revenue_generated
#   # => 0
#
# Returns the Item object created.
def item_without_revenue(ii_count: 4, status: 'packaged', result: 'failed')
  result = %w[failed refunded].sample if status == 'shipped'
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant: item.merchant, status: status) do |invoice|
      FactoryBot.create(:transaction, result: result, invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end

# Internal: Creates a list of Items with a random amount of revenue.  This
# method is intended to be used for test cases where revenue needs to be
# evaluated, but knowing the total revenue or order of Items by revenue is not
# needed.  See above for #item_with_revenue to understand the other objects
# created.
#
# quantity - The Integer quantity of Items to create (Default: 20)
#
# Returns the Integer quantity of Items created.
def items_with_random_revenue(quantity = 20)
  quantity.times { item_with_revenue(ii_count: rand(1..10)) }
end
