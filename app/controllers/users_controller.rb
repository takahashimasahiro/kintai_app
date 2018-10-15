class UsersController < ApplicationController
  before_action :authenticate_current_user

  @dateofweek = ["日","月","火","水","木","金","土"]
  def home
    @today = Date.today
    @show_years = []
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.find_by(user_id: @current_user.id)
  end

  def show
    @today = params[:select_year]
    @show_years = []
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
    render('users/home')
  end

  def save
    # テーブルに登録する処理
    render('users/home')
  end
end
