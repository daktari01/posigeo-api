require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /api/v1/login" do
    context "with valid credentials" do
      it "returns a token and success message" do
        post "/api/v1/login", params: { email: "daktari@posigeo.com", password: "password" }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['token']).to be_present
        expect(json_response['message']).to eq("Successfully logged in")
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized status" do
        post "/api/v1/login", params: { email: "wrong@posigeo.com", password: "wrongpassword" }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['errors'][0]['detail']).to eq("Invalid credentials")
      end
    end

    context "with missing credentials" do
      it "returns unauthorized status" do
        post "/api/v1/login"

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['errors'][0]['detail']).to eq("Invalid credentials")
      end
    end
  end
end
