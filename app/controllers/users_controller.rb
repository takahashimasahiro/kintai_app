class UsersController < ApplicationController
  before_action :authenticate_current_user

  def home
    @DATE_OF_WEEK = ["日","月","火","水","木","金","土"].freeze
    @WORK_STATUS = ['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤'].freeze
    @today = Date.today
    @show_years = []
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.find_by(user_id: @current_user.id)
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
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
