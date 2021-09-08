module Api
  module V1
    module Merchants
      class ItemsValidator
        include ActiveModel::Validations

        attr_accessor :merchant_id

        validates :merchant_id, presence: true, numericality: true

        def initialize(data = {})
          @merchant_id = data[:merchant_id]
        end
      end
    end
  end
end
