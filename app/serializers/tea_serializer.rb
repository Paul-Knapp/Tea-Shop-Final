class TeaSerializer
  include JSONAPI::Serializer
  
  attributes :title, :description, :temperature, :brew_time

  has_many :subscriptions
end
