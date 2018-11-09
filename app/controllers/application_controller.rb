# BaseController
class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    if logged_in?
      @current_user ||= User.find(session[:id])
    end
  end

  # ログインしていない場合は中の画面を表示させない
  def authenticate_current_user
    if !logged_in? || !@current_user
      flash[:notice] = 'ログインが必要です'
      redirect_to('/')
    end
  end

  # すでにログインしている場合はログイン画面を表示させない
  def forbid_current_user
    if logged_in?
      redirect_to attendance_path(session[:id])
    end
  end

  # ログイン状態か判別
  def logged_in?
    session[:id]
  end

  # 有休申請数がいつくなのか数える
  def apply_count
    @apply_count = 0
    if are_you_owner?
      @apply_count = ApplyVacation.where(status: 'applying').count
    end
  end

  # オーナーか判別する
  def are_you_owner?
    @current_user.role == 'owner'
  end
end
