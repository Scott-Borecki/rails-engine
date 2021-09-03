FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..20) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    invoice
    item
  end
end
