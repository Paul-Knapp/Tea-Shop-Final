class Subscription < ApplicationRecord
  validates :title, :price, :status, :frequency, presence: true
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
end
