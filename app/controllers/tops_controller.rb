class TopsController < ApplicationController
  before_action :authenticate_current_user, {only: [:logout]}
  before_action :fobid_current_user, {only: [:top, :new, :login]}

  def top
    session[:user_id] = nil
  end

  def new
    
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.user_id
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
    session[:user_id] = nil
    redirect_to('/')
  end
end
