class GeolocationSerializer
  include JSONAPI::Serializer

  set_type :geolocations

  attributes :ip_address, :url, :country, :country_code, :city, :latitude, :longitude, :created_at, :updated_at

  attribute :data do |object|
    object.data
  end
end
