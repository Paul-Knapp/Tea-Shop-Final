class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :image_url, presence: true

  has_many :teas
  belongs_to :customer
end
