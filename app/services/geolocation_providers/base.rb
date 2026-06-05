module GeolocationProviders
  class Base
    def fetch(ip_or_url)
      raise NotImplementedError, "Subclasses must implement #fetch"
    end

    private

    def valid_ip?(ip)
      return false if ip.blank?
      IPAddr.new(ip).ipv4?
    rescue IPAddr::InvalidAddressError, IPAddr::AddressFamilyError
      false
    end
  end
end