class HolidaysController < ApplicationController
  def show
    @my_vacation = @current_user.apply_vacations.all.order(:get_start_date)
  end
  def edit 
    @applying_vacation = User.joins(:apply_vacations).select("apply_vacations.* , users.name ").order("apply_vacations.get_start_date")
  end
  
  def update
    redirect_to edit_holiday_path(@current_user.id) ,flash: {notice: '保存しました'}
  end
end
