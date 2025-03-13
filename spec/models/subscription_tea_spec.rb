require 'rails_helper'

RSpec.describe SubscriptionTea, type: :model do
  it ' has associations' do
    should belong_to(:subscription)
    should belong_to(:tea)
  end 
end
