require 'rails_helper'

RSpec.describe "API::V1::Subscriptions", type: :request do
before(:each) do
    @customer = Customer.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      address: "123 Tea Street, Teatown, TX"
    )

    @tea1 = Tea.create!(
      title: "Green Tea",
      description: "A refreshing and healthy tea",
      temperature: 80,
      brew_time: "2-3 minutes"
    )

    @tea2 = Tea.create!(
      title: "Black Tea",
      description: "A strong and bold tea",
      temperature: 95,
      brew_time: "3-5 minutes"
    )

    @subscription = Subscription.create!(
      title: "Monthly Tea Box",
      price: 19.99,
      status: "active",
      frequency: "monthly",
      customer: @customer
    )

    @subscription.teas << [@tea1, @tea2]
  end

  describe "GET /api/v1/subscriptions" do
    it "returns all subscriptions" do
      get "/api/v1/subscriptions"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(1)
      expect(json[:data][0][:attributes][:title]).to eq("Monthly Tea Box")
    end
  end

  describe "GET /api/v1/subscriptions/:id" do
    it "returns a single subscription" do
      get "/api/v1/subscriptions/#{@subscription.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:id]).to eq(@subscription.id.to_s)
      expect(json[:data][:attributes][:title]).to eq("Monthly Tea Box")
    end
  end

  describe "PATCH /api/v1/subscriptions/:id" do
    it "updates a subscription" do
      patch "/api/v1/subscriptions/#{@subscription.id}", 
        params: { status: "cancelled" }.to_json,
        headers: { "Content-Type": "application/json" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data][:attributes][:status]).to eq("cancelled")
    end

    it "returns an error for an invalid subscription ID" do
      patch "/api/v1/subscriptions/9999", 
        params: { status: "cancelled" }.to_json,
        headers: { "Content-Type": "application/json" }

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("Subscription not found")
    end
  end
end
