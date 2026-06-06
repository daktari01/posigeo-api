require 'rails_helper'

RSpec.describe "Api::V1::Geolocations", type: :request do
  let(:valid_ip) { "8.8.8.8" }
  let(:valid_url) { "google.com" }

  describe "GET /api/v1/geolocations (lookup)" do
    context "when record exists in database" do
      let!(:geolocation) { create(:geolocation, ip_address: valid_ip) }

      it "returns the geolocation data" do
        get "/api/v1/geolocations/lookup", params: { ip: valid_ip }

        expect(response).to have_http_status(:ok)
        expect(json_response['data']['attributes']['ip_address']).to eq(valid_ip)
        expect(json_response['data']['attributes']['country']).to be_present
      end
    end

    context "when record does not exist" do
      let(:geolocation) do
        create(:geolocation,
              ip_address: valid_ip,
              country: "United States",
              city: "Mountain View")
      end

      before do
        allow_any_instance_of(GeolocationService).to receive(:lookup).and_return(geolocation)
      end

      it "fetches from external service and returns data" do
        get "/api/v1/geolocations/lookup", params: { ip: valid_ip }

        expect(response).to have_http_status(:ok)
        expect(json_response['data']['attributes']['ip_address']).to eq(valid_ip)
      end
    end

    context "with URL instead of IP" do
      let(:geolocation) { create(:geolocation, ip_address: "172.217.170.174") }

      before do
        allow_any_instance_of(GeolocationService).to receive(:lookup).and_return(geolocation)
      end

      it "accepts url parameter" do
        get "/api/v1/geolocations/lookup", params: { url: valid_url }

        expect(response).to have_http_status(:ok)
      end
    end

    context "when ip/url is missing" do
      it "returns validation error" do
        get "/api/v1/geolocations/lookup"

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors'][0]['detail']).to include("IP or URL is required")
      end
    end
  end

  describe "POST /api/v1/geolocations" do
    let(:geolocation) do
      create(:geolocation,
            ip_address: valid_ip,
            country: "Kenya",
            city: "Mombasa")
    end

    before do
      allow_any_instance_of(GeolocationService).to receive(:lookup).and_return(geolocation)
    end

    it "creates and returns geolocation with status 201" do
      post "/api/v1/geolocations", params: { ip: valid_ip }

      expect(response).to have_http_status(:created)
      expect(json_response['data']['attributes']['ip_address']).to eq(valid_ip)
    end

    it "returns error when ip/url is missing" do
      post "/api/v1/geolocations"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /api/v1/geolocations/:id" do
    let!(:geolocation) { create(:geolocation, ip_address: valid_ip) }

    it "deletes the geolocation" do
      expect {
        delete "/api/v1/geolocations/#{geolocation.id}"
      }.to change(Geolocation, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns not found when geolocation doesn't exist" do
      delete "/api/v1/geolocations/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
