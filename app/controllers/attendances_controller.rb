class AttendancesController < ApplicationController
  def new
  end

  def show
    @today = Date.today
    if params[:select_year] && params[:select_month]
      @today = @today.change(year: params[:select_year].to_i, month: params[:select_month].to_i)
    end
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.where(:work_date => @today.all_month,user_id: @current_user.id)
  end

  def update
    @today 
    byebug
    redirect_to attendance_path(@current_user.id)
  end
end