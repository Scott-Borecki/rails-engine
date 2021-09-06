FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::GreekPhilosophers.quote }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant
  end
end

def item_with_revenue(invoice_items_count: 4)
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant: item.merchant, status: 'shipped') do |invoice|
      FactoryBot.create(:transaction, result: 'success', invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, invoice_items_count, item: item, invoice: invoice)
    end
  end
end

def item_without_revenue(invoice_items_count: 4)
  FactoryBot.create(:item) do |item|
    FactoryBot.create(:invoice, merchant: item.merchant, status: 'packaged') do |invoice|
      FactoryBot.create(:transaction, result: 'success', invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, invoice_items_count, item: item, invoice: invoice)
    end
  end
end

def items_with_random_revenue(quantity)
  quantity.times { item_with_revenue(invoice_items_count: rand(1..10)) }
end
