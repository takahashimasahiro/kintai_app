class UsersController < ApplicationController
  # before_action :authenticate_current_user
  def new
    @user = User.new
    session[:id] = nil
    @current_user = nil
    @error_messages =nil
  end
  
  def create
    @user = User.new(user_params)
    @user.name = "テストユーザー"
    if @user.save
      session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: {notise: 'ログインしました'}
    else
      @email = params[:email]
      @password = params[:password]
      # redirect_to new_user_path
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
