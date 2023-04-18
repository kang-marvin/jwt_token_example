class UsersController < ApplicationController

  before_action :find_user, only: [ :show, :update, :destroy]

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    @person_of_fun
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 503
    end
  end

  def update
    if @user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  def destroy
    @user.destroy
  end

  private


  def user_params
    params.permit(:email, :user_name, :password)
  end

  def find_user
    @user = User.find_by(params[:id])
  end
end
