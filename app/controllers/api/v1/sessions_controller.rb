class Api::V1::SessionsController < ApplicationController
  if params[:email] == "daktari@posigeo.com" && params[:password] == "password"
    token = JWT.encode({ user_id: 1, exp: 24.hours.from_now.to_i }, ENV['JWT_SECRET'], 'HS256')
    render json: { token: token, message: "Successfully logged in" }, status: :ok
  else
    render json: { errors: [{ detail: "Invalid credentials" }] }, status: :unauthorized
  end
end
