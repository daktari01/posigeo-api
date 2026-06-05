module GeolocationProviders
  class Base
    def fetch(ip_or_url)
      raise NotImplementedError
    end

    private

    def valid_ip?(ip)
      IPAddr.new(ip).ipv4?
    rescue IPAddr::InvalidAddressError
      false
    end
  end
end
