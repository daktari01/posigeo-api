class GeolocationSerializer
  include JSONAPI::Serializer

  attributes :ip_address, :url, :country, :country_code, :city, :latitude, :longitude, :data
end
