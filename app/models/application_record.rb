class ApplicationRecord < ActiveRecord::Base
  extend Convertable

  self.abstract_class = true
end
