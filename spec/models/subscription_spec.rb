require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'has associations' do
    should belong_to(:customer)
    should have_many(:subscription_teas)
    should have_many(:teas).through(:subscription_teas)
    should validate_presence_of(:title)
    should validate_presence_of(:price)
    should validate_presence_of(:status)
    should validate_presence_of(:frequency)
  end
end
