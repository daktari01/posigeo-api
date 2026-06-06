require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  it { should validate_presence_of(:ip_address) }
  it { should validate_uniqueness_of(:ip_address).case_insensitive }
end
