class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
      @current_user = User.find_by(user_id: session[:user_id])
    end
  end

  def authenticate_current_user
    if @current_user == nil
      flash[:notice] = 'ログインが必要です'
      redirect_to('/')
    end
  end

  def fobid_current_user
    if @current_user
      flash[:notice] = 'すでにログインしています'
      redirect_to('/users/home')
    end
  end
end
