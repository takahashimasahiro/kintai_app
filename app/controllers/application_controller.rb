# frozen_string_literal: true

# BaseController
class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:id]) if logged_in?
  end

  # ログインしていない場合は中の画面を表示させない
  def authenticate_current_user
    if !(logged_in? && @current_user)
      flash[:notice] = 'ログインが必要です'
      redirect_to('/')
    end
  end

  # すでにログインしている場合はログイン画面を表示させない
  def forbid_current_user
    redirect_to attendance_path(session[:id]) if logged_in?
  end

  # ログイン状態か判別
  def logged_in?
    session[:id]
  end

  # 有休申請数がいつくなのか数える
  def apply_count
    @apply_count = ApplyVacation.where(status: :applying).count if @current_user.owner?
  end

end
