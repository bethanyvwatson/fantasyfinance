class Label < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :profile, presence: true

  belongs_to :profile
  has_many :transactions
end
