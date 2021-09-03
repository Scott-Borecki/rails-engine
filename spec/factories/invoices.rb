FactoryBot.define do
  factory :invoice do
    status { ['shipped', 'packaged', 'returned'].sample }
    customer
    merchant
  end
end
