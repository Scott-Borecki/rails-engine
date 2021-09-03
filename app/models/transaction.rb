class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true,
                                 numericality: true,
                                 length: { in: 15..16 }
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true,
                     inclusion: { in: %w[failed success refunded] }
end
