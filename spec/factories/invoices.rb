FactoryBot.define do
  factory :invoice do
    status { %w[shipped packaged returned].sample }
    customer
    merchant
  end
end

def invoice_with_revenue(ii_count: 4, status: 'shipped', result: 'success')
  FactoryBot.create(:invoice, status: status) do |invoice|
    FactoryBot.create(:item) do |item|
      FactoryBot.create(:transaction, result: result, invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end

def invoice_without_revenue(ii_count: 4, status: 'shipped', result: 'failed')
  FactoryBot.create(:invoice, status: status) do |invoice|
    FactoryBot.create(:item) do |item|
      FactoryBot.create(:transaction, result: result, invoice: invoice)
      FactoryBot.create_list(:invoice_item_fixed, ii_count, item: item, invoice: invoice)
    end
  end
end
