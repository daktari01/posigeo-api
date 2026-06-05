FactoryBot.define do
  factory :geolocation do
    ip_address { "MyString" }
    url { "MyString" }
    country { "MyString" }
    country_code { "MyString" }
    city { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    data { "" }
  end
end
