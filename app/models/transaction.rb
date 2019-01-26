class Transaction < ApplicationRecord
  REQUIRED_ATTRS = %i(amount date description).freeze
  validates :amount, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
