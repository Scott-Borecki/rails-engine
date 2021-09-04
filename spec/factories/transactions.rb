FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-').to_s }
    credit_card_expiration_date { "#{month}/#{year}" }
    result { %w[failed success refunded].sample }
    invoice
  end
end

def month
  rand(1..12).to_s.rjust(2, '0')
end

def year(range = 22..25)
  rand(range)
end
