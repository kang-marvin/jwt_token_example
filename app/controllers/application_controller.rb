class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    begin
      decoded = Security::JwtToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: 401
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: 401
    end
  end
end
