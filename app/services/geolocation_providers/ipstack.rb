module GeolocationProviders
  class Ipstack < Base
    BASE_URL = "http://api.ipstack.com".freeze

    def initialize(api_key = ENV["IPSTACK_API_KEY"])
      @api_key = api_key
    end

    def fetch(ip_or_url)
      # Resolve URL to IP
      ip = resolve_to_ip(ip_or_url)
      return { error: "Invalid IP/URL" } unless ip

      response = HTTParty.get("#{BASE_URL}/#{ip}", query: { access_key: @api_key })

      if response.success?
        parse_response(response)
      else
        { error: response.parsed_response }
      end
    end

    private

    def resolve_to_ip(address)
      return address if valid_ip?(address)
      Resolv.getaddress(address) rescue nil
    end

    def parse_response(data)
      {
        ip: data["ip"],
        country: data["country_name"],
        country_code: data["country_code"],
        city: data["city"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        data: data
      }
    end
  end
end
