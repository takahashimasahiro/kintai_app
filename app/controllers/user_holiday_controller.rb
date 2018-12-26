class UserHolidayController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @my_vacations = @current_user.apply_vacations.all.order(:get_start_date)
  end

  def update
    vacation = ApplyVacation.find_by(get_start_date: params[:date], applicant_id: @current_user.id)
    vacation.applied_reason = params[:reason]
    vacation.save!
    redirect_to user_holiday_path(@current_user.id), flash: { notice: t(:save_success, scope: :messages) }
  rescue StandardError => e
    @error_message = e.message
    redirect_to user_holiday_path(@current_user.id), flash: { notice: t(:save_failed, scope: :messages) }
  end
end
