# LoginFormsController
class SessionsController < ApplicationController
  before_action :forbid_current_user, {only: [:top, :new, :login, :create]}
  def top
    session[:user_id] = nil
    render('sessions/top')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name = "テストユーザー"
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
    @user = User.find_by(params[:email])
    if @user && @user.authenticate(params[:password])
    # @user = User.find_by(email: 'admin@example.com')
    # if @user && @user.authenticate('password')
        session[:id] = @user.id
      redirect_to '/users/home', flash: {notice: 'ログインしました'}
    else
      @error_message = 'アドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      render('sessions/top')
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def logout
    session[:id] = nil
    redirect_to('/')
  end
end
