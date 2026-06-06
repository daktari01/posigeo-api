require 'rails_helper'

RSpec.describe GeolocationService do
  let(:service) { described_class.new }

  it "fetches and stores geolocation" do
    provider_double = instance_double(GeolocationProviders::Ipstack)
    allow(provider_double).to receive(:fetch).with("8.8.8.8").and_return(
      {
        ip: "8.8.8.8",
        country: "United States",
        country_code: "US",
        city: "Mountain View",
        latitude: 37.4056,
        longitude: -122.0775
      }
    )
    allow(GeolocationProviders::Ipstack).to receive(:new).and_return(provider_double)

    geo = service.lookup("8.8.8.8")
    expect(geo).to be_persisted
    expect(geo.country).to be_present
  end
end
