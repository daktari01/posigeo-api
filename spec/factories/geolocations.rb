FactoryBot.define do
  factory :geolocation do
    ip_address { "8.8.8.8" }
    country { "United States" }
    country_code { "US" }
    city { "Mountain View" }
    latitude { 37.4056 }
    longitude { -122.0775 }
    data { { "ip" => "8.8.8.8" } }
  end
end
