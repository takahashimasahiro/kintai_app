# BaseController
class ApplicationController < ActionController::Base
  before_action :current_user
  def current_user
    if logged_in?
      @current_user ||= User.find(session[:id])
    end
  end

  def authenticate_current_user
    if !logged_in? || !@current_user
      flash[:notice] = 'ログインが必要です'
      redirect_to('/')
    end
  end

  def forbid_current_user
    if logged_in?
      redirect_to attendance_path(session[:id])
    end
  end
  # ログイン状態か判別
  def logged_in?
    session[:id]
  end
end
