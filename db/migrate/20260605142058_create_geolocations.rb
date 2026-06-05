class CreateGeolocations < ActiveRecord::Migration[8.0]
  def change
    create_table :geolocations do |t|
      t.string :ip_address, index: { unique: true }
      t.string :url
      t.string :country
      t.string :country_code
      t.string :city
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.jsonb :data, default: {}

      t.timestamps
    end
  end
end
