FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end

def merchant_with_revenue(invoice_items_count: 4)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant: merchant) do |item|
      FactoryBot.create(:invoice, merchant: merchant, status: 'shipped') do |invoice|
        FactoryBot.create(:transaction, result: 'success', invoice: invoice)
        FactoryBot.create_list(:invoice_item_fixed, invoice_items_count, item: item, invoice: invoice)
      end
    end
  end
end

def merchant_without_revenue(invoice_items_count: 4)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create(:item, merchant: merchant) do |item|
      FactoryBot.create(:invoice, merchant: merchant, status: 'packaged') do |invoice|
        FactoryBot.create(:transaction, result: 'success', invoice: invoice)
        FactoryBot.create_list(:invoice_item_fixed, invoice_items_count, item: item, invoice: invoice)
      end
    end
  end
end

def merchants_with_revenue(quantity)
  quantity.times { merchant_with_revenue }
end

def merchants_with_random_revenue(quantity)
  quantity.times { merchant_with_revenue(invoice_items_count: rand(1..10)) }
end

def merchants_without_revenue(quantity, random_ii_count = false)
  if random_ii_count == true
    quantity.times { merchant_without_revenue(invoice_items_count: rand(1..10)) }
  else
    quantity.times { merchant_without_revenue }
  end
end
