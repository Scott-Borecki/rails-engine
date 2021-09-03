FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-').to_s }
    credit_card_expiration_date { "#{["0" + rand(1..9).to_s, rand(10..12)].sample}/#{rand(22..25)}" }
    result { ['failed', 'success', 'refunded'].sample }
    invoice
  end
end
