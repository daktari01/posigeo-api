class Geolocation < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: true, format: { with: Resolv::IPv4::Regex }
  validates :latitude, :longitude, numericality: true, allow_nil: true
end
