class Api::HolidayController < ApplicationController
  def edit
    holiday = ApplyVacation.where(applicant_id: params[:id])
    render json: holiday
  end

  def update; end
end
