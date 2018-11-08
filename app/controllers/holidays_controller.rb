class HolidaysController < ApplicationController
  def show
    @my_vacation = @current_user.apply_vacations.all.order(:get_start_date)
  end
  def edit 
    # @applying_vacation = ApplyVacation.where(status: 'applying').order(:get_start_date)
    @applying_vacation = User.joins(:apply_vacations).select("apply_vacations.* , users.name ").order("apply_vacations.get_start_date")
    # a = ApplyVacation.joins(:users).select("users.*, apply_vacations.* ").where("apply_vacations.applicant_id == users.id").first
  end
  
  def update
  end
end
