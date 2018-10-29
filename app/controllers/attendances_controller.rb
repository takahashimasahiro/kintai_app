class AttendancesController < ApplicationController
  @select_date 

  def new
  end

  def show
    @select_date = Date.today
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i)
    end
    @lastday = @select_date.end_of_month.day
    @attendance_table = AttendanceTime.where(:work_date => @select_date.all_month,user_id: @current_user.id)
  end

  def update
    @select_date = Date.today
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i)
    end
    byebug()
    (1.. @select_date.end_of_month.day).each do |i|
      # 登録する日付を宣言
      @registration_date = Date.new(
        params[:"work_#{i}"]["start(1i)"].to_i,
        params[:"work_#{i}"]["start(2i)"].to_i,
        params[:"work_#{i}"]["start(3i)"].to_i)

      # 日付をもとにcreate or update 
      @attend = AttendanceTime.find_or_initialize_by(user_id: @current_user.id ,work_date: @registration_date)
      @attend.work_start = DateTime.new(
        params[:"work_#{i}"]["start(1i)"].to_i,
        params[:"work_#{i}"]["start(2i)"].to_i,
        params[:"work_#{i}"]["start(3i)"].to_i,
        params[:"work_#{i}"]["start(4i)"].to_i,
        params[:"work_#{i}"]["start(5i)"].to_i,
        0,"+09:00")
      @attend.work_end = DateTime.new(
        params[:"work_#{i}"]["end(1i)"].to_i,
        params[:"work_#{i}"]["end(2i)"].to_i,
        params[:"work_#{i}"]["end(3i)"].to_i,
        params[:"work_#{i}"]["end(4i)"].to_i,
        params[:"work_#{i}"]["end(5i)"].to_i,
        0,"+09:00")
      @attend.status = params[:"status_#{i}"]
      @attend.save
    end
    redirect_to attendance_path(@current_user.id), flash: {notise: '保存しました'}
  end
end