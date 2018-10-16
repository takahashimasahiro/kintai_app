# LoginFormsController
class SessionsController < ApplicationController
  before_action :forbid_current_user, {only: [:top, :new, :login, :create]}
  def top
    session[:user_id] = nil
    render('sessions/top')
  end

  def new
  end

  def create
    @user = User.new(email: params[:email],name: params[:email],password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect_to '/users/home', flash: {notise: 'ログインしました'}
    else
      @error_message = 'エラーメッセージ'
      @email = params[:email]
      @password = params[:password]
      render('sessions/new')
    end
  end

  def login
    # @user = User.find_by(email: params.require(:user).parmit(:email))
    # if @user && @user.authenticate(params.require(:user).parmit(:password))
    @user = User.find_by(email: 'admin@example.com')
    if @user && @user.authenticate('password')
        session[:id] = @user.id
      redirect_to '/users/home', flash: {notice: 'ログインしました'}
    else
      @error_message = 'アドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      render('sessions/top')
    end
  end

  def logout
    session[:id] = nil
    redirect_to('/')
  end
end
