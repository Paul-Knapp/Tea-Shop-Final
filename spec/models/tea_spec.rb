require 'rails_helper'

RSpec.describe Tea, type: :model do
  it 'associations' do
    should have_many(:subscription_teas)
    should have_many(:subscriptions).through(:subscription_teas)
    should validate_presence_of(:title)
    should validate_presence_of(:description)
  end
end
