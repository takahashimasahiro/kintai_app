class UsersController < ApplicationController
  before_action :authenticate_current_user

  def home
    @today = Date.today
    @show_years = []
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.find_by(user_id: @current_user.id)
  end

  def show
    @today = params[:select_year]
    @show_years = []
    render('users/home')
  end

  def save
    # テーブルに登録する処理
    render('users/home')
  end
end
