class GeolocationService
  def initialize(provider_class = GeolocationProviders::Ipstack)
    @provider = provider_class.new
  end

  def lookup(ip_or_url)
    data = @provider.fetch(ip_or_url)
    return data if data[:error]

    Geolocation.find_or_create_by(ip_address: data[:ip]) do |geo|
      geo.assign_attributes(data.except(:ip))
    end
  end
end
