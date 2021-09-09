FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..20) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    invoice
    item
  end

  # Internal: Creates an InvoiceItem object with a fixed quantity and price.
  # The purpose of this method is to allow the user to manufacture a known
  # potential revenue for an Invoice, Item, or Merchant by associating a known
  # quantity of fixed InvoiceItems with the object.
  #
  # Returns the InvoiceItem object created.
  factory :invoice_item_fixed, parent: :invoice_item do
    quantity { 1 }
    unit_price { 1.50 }
  end
end
