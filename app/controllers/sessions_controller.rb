# LoginFormsController
class SessionsController < ApplicationController
  # before_action :forbid_current_user, {only: [:login]}

  def new
    session[:id] = nil
    @current_user = nil
    @error_messages = nil
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: {notice: 'ログインしました'}
    else
      @error_messages = "メールアドレスもしくはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render :action => 'new'
    end
  end

end
