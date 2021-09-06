FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..20) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    invoice
    item
  end

  factory :invoice_item_fixed, parent: :invoice_item do
    quantity { 1 }
    unit_price { 1.50 }
  end
end
