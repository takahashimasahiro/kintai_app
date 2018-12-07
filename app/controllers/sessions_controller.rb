# LoginFormsController
class SessionsController < ApplicationController
  before_action :forbid_current_user, only: %i[login new]
  before_action :authenticate_current_user, only: %i[destroy]

  def new
    @user = User.new
    session[:id] = nil
    @current_user = nil
    render :new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: { notice: 'ログインしました' }
    else
      @error_message = 'メールアドレスもしくはパスワードが間違っています'
      render :new
      # render login_path
    end
  end

  def destroy
    session[:id] = nil
    @current_user = nil
    @error_message = nil
    render :new
  end
end
