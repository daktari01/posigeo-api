module Authenticable
  def authenticate!
    header = request.headers["Authorization"]
    token = header.split(" ")&.last

    if token.blank?
      return render json: { error: [{ detail: "Auth token is needed" }] }, status: :unauthorized
    end

    begin
      decoded_token = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      @current_user = decoded_token[0]['user_id']
    rescue JWT::ExpiredSignature
      render json: { error: [{ detail: "Token has expired" }] }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: [{ detail: "Invalid auth token" }] }, status: :unauthorized
    end
  end
end
