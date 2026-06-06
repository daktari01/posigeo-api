class Api::V1::GeolocationsController < ApplicationController
  before_action :set_geo, only: [ :destroy ]

  def lookup
    ip_or_url = params[:ip] || params[:url]

    if ip_or_url.blank?
      return render json: {
        errors: [ { detail: "IP or URL is required (use ?ip= or ?url=)" } ]
      }, status: :unprocessable_entity
    end

    geo = Geolocation.find_by(ip_address: ip_or_url)

    unless geo
      geo = GeolocationService.new.lookup(ip_or_url)
    end

    if geo.is_a?(Geolocation) && geo.persisted?
      render json: GeolocationSerializer.new(geo).serializable_hash,
             status: :ok
    else
      render json: {
        errors: [ { detail: geo[:error] || "Failed to fetch geolocation" } ]
      }, status: :unprocessable_entity
    end
  end

  def create
    ip_or_url = params[:ip] || params[:url]

    if ip_or_url.blank?
      return render json: { errors: [ { detail: "IP or URL is required" } ] },
                    status: :unprocessable_entity
    end

    service = GeolocationService.new
    result = service.lookup(ip_or_url)

    if result.is_a?(Geolocation) && result.persisted?
      render json: GeolocationSerializer.new(result).serializable_hash, status: :created
    else
      error_message = result[:error] || "Failed to fetch geolocation"
      render json: { errors: [ { detail: error_message } ] }, status: :unprocessable_entity
    end
  end

  def destroy
    if @geo&.destroy
      head :no_content
    else
      render json: { errors: [ { detail: "Not found" } ] }, status: :not_found
    end
  end

  private

  def set_geo
    @geo = Geolocation.find(params[:id])
  end

  def geolocation_params
    params.require(:geolocation).permit(
      :ip_address,
      :latitude,
      :longitude,
      :url,
      :country,
      :country_code,
      :city
    )
  end
end
