class AuthenticationController < ApplicationController

  skip_before_action :authenticate_user

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = Security::JwtToken.encode({user_id: @user.id})
      render json: { token: token, username: @user&.user_name }, status: 200
    else
      render json: { error: 'unauthorized' }, status: 401
    end
  end
end
