class HolidaysController < ApplicationController
  def show
    @my_vacation = @current_user.apply_vacations.all.order(:get_start_date)
  end
  def edit 
  end
  def update
  end
end
