class Tea < ApplicationRecord
    has_many :subscription_teas
    has_many :subscriptions, through: :subscription_teas
    validates :title,:description, presence: true
end
