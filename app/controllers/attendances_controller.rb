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
    byebug
    @select_date = Date.today
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i)
    end

    (1.. @select_date.end_of_month.day).each do |i|
      # params[:work_1]["start(4i)"]
      # params[:status_1]
      # {"start(1i)"=>"2018", "start(2i)"=>"10", "start(3i)"=>"1", "start(4i)"=>"10", "start(5i)"=>"00",
      #    "end(1i)"=>"2018", "end(2i)"=>"10", "end(3i)"=>"1", "end(4i)"=>"19", "end(5i)"=>"00"},
      #     "status_1"=>"出勤",
      
      # 登録する日付を宣言
      @registration_date = Date.new(
        params[':work_#{i}']['start(1i)'].to_i,
        params[':work_#{i}']['start(2i)'].to_i,
        params[':work_#{i}']['start(3i)'].to_i)

      # 日付をもとにcreate or update 
      @attend = AttendanceTime.find_or_initialize_by(user_id: @current_user.id ,work_date: @registration_date)
      @attend.work_start = Date.new()
      @attend.work_end = Date.new()
      @attend.status = params[:status_1]
      @attend.save
    end
    redirect_to attendance_path(@current_user.id)
  end
end