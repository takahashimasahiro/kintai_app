# LoginFormsController
class TopsController < ApplicationController
  # before_action :authenticate_current_user, {only: [:logout]}
  before_action :fobid_current_user, {only: [:top, :new, :login, :create]}

  def top
    session[:user_id] = nil
  end

  def new

  end

  def create
    @user = User.new(email: params[:email],
                     name: params[:email],
                     paid_holiday_count: 10,
                     password: params[:password])
    if @user.save
      session[:id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to('/users/home')
    else
      @error_message = 'エラーメッセージ'
      @email = params[:email]
      @password = params[:password]
      render('tops/new')
    end
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to('/users/home')
    else
      @error_message = 'アドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      render('tops/top')
    end
  end

  def logout
    session[:id] = nil
    redirect_to('/')
  end
end
