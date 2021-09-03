FactoryBot.define do
  factory :invoice do
    status { %w[shipped packaged returned].sample }
    customer
    merchant
  end
end
