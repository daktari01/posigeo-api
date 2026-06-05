class Api::V1::GeolocationsController < ApplicationController
  before_action :set_geo, only: [ :show, :destroy ]

  def show
    geo = @geo || GeolocationService.new.lookup(params[:id])

    if geo.is_a?(Geolocation)
      render json: GeolocationSerializer.new(geo).serializable_hash, status: :ok
    else
      render json: { errors: [ { detail: geo[:error] } ] }, status: :unprocessable_entity
    end
  end

  def create
    service = GeolocationService.new
    geo = service.lookup(params[:id] || params[:url])

    if geo.persisted?
      render json: GeolocationSerializer.new(geo).serializable_hash, status: :created
    else
      render json: { errors: geo.errors }, status: :unprocessable_entity
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
    @geo = Geolocation.find_by(ip_address: params[:id])
  end

end
