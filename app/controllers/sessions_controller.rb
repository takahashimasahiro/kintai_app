# LoginFormsController
class SessionsController < ApplicationController
  before_action :forbid_current_user, {only: [:login]}

  def new
    session[:user_id] = nil
    @current_user = nil
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: {notice: 'ログインしました'}
    else
      @error_message = 'アドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      redirect_to new_session_path
    end
  end

end
