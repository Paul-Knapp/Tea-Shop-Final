require 'rails_helper'

RSpec.describe "Api::V1::Teas", type: :request do
  before(:each) do
    @tea1 = Tea.create!(
      title: "Green Tea",
      description: "A refreshing and healthy tea",
      temperature: 80,
      brew_time: "2"
    )

    @tea2 = Tea.create!(
      title: "Black Tea",
      description: "A strong and bold tea",
      temperature: 95,
      brew_time: "3"
    )
  end

  describe "GET /api/v1/teas" do
    it "returns all teas" do
      get "/api/v1/teas"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(2)
      expect(json[:data][0][:attributes][:title]).to eq("Green Tea")
      expect(json[:data][1][:attributes][:title]).to eq("Black Tea")
    end
  end

  describe "GET /api/v1/teas/:id" do
    it "returns a single tea" do
      get "/api/v1/teas/#{@tea1.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to eq(@tea1.id.to_s)
      expect(json[:data][:attributes][:title]).to eq("Green Tea")
      expect(json[:data][:attributes][:description]).to eq("A refreshing and healthy tea")
      expect(json[:data][:attributes][:temperature]).to eq(80)
      expect(json[:data][:attributes][:brew_time]).to eq(2)
    end
  end
end
