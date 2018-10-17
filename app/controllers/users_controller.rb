class UsersController < ApplicationController
  before_action :authenticate_current_user

  def home
    @DATE_OF_WEEK = ["日","月","火","水","木","金","土"].freeze
    @WORK_STATUS = ['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤'].freeze
    @today = Date.today
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.where(:work_date => @today.all_month,user_id: @current_user.id)
  end

  def show
    @today = params[:select_year]
    render('users/home')
  end

  def save
    # テーブルに登録する処理
    render('users/home')
  end
end
