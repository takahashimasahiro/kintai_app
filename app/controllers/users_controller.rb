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
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def edit
  end

  def update 
    @user = User.find(@current_user.id)
    if params[:new_password1] == params[:new_password2] && @user.authenticate(params[:old_password])
        @user.name = params[:page]['name']
        @user.password = params[:new_password1]
        if @user.save
          redirect_to edit_user_path(@current_user.id) ,flash: {notice: '保存しました'}
          # render 'edit'
        else
          render 'edit'
        end
    else
      @error_messages = 'パスワードが異なっています'
      render 'edit'
    end
  end
end
