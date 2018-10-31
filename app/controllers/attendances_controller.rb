class AttendancesController < ApplicationController
  def new
  end
  def show
    @select_date = Time.now
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i,day:1)
    end
    if @current_user.role == 'owner'
      @user_all = User.all.map { |x| [x.name, x.id] }
    end

    @lastday = @select_date.end_of_month.day
    @selected_user = params[:select_user] ? User.find(params[:select_user]) : @current_user
    @attendance_table = @selected_user.attendance_times.where(:work_date => @select_date.all_month)

    @selected_user = [@selected_user.name,@selected_user.id]
  end

  def update
    @select_date = Time.now
    # TODO チェンジフラグ　全部やるのはNG
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i,day:1)
    end
    (1.. @select_date.end_of_month.day).each do |i|
      # 登録する日付を宣言
      @registration_date = DateTime.new(
        params[:"work_#{i}"]["start(1i)"].to_i,
        params[:"work_#{i}"]["start(2i)"].to_i,
        params[:"work_#{i}"]["start(3i)"].to_i)

      # 日付をもとにcreate or update 
      if @current_user.role == 'owner'
        @attend = AttendanceTime.find_or_initialize_by(user_id: params[:select_user] ,work_date: @registration_date)
      else
        @attend = AttendanceTime.find_or_initialize_by(user_id: @current_user.id ,work_date: @registration_date)
      end
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
    redirect_to attendance_path(@current_user.id), flash: {notice: '保存しました'}
  end
end