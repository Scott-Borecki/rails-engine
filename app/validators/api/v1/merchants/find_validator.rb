module Api
  module V1
    module Merchants
      class FindValidator
        include ActiveModel::Validations

        attr_accessor :name

        validates :name, presence: true

        def initialize(data = {})
          @name = data[:name]
        end
      end
    end
  end
end
