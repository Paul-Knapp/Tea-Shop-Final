require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'has associations' do
    should have_many(:subscriptions)
    should have_many(:teas).through(:subscriptions)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:address)
  end
end
