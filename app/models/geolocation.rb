class Geolocation < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: Resolv::IPv4::Regex }
  validates :latitude, :longitude, numericality: true, allow_nil: true
end
