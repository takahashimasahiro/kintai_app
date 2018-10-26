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
    @select_date 
    byebug
    @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i)
    redirect_to attendance_path(@current_user.id)
  end
end