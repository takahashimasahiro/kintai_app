class HolidaysController < ApplicationController

  def show
    @my_vacation = @current_user.apply_vacations.all.order(:get_start_date)
  end

  def edit
    # @applying_vacation = User.joins(:apply_vacations).select("apply_vacations.* , users.name ").order("apply_vacations.get_start_date")
    @applying_vacation = User.joins(:apply_vacations).where(apply_vacations: {status: 'applying'}).select("apply_vacations.* , users.name ")
  end
  
  def update
    @vacation_data = ApplyVacation.find_by(applicant_id: params[:user_id], get_start_date: params[:get_date])
    if @vacation_data
      if params[:approve]
        @vacation_data.status = 'admin_applied'
        reduce_holiday_count(@vacation_data)
      elsif params[:dismiss]
        @vacation_data.status = 'apply_rejection'
        change_attend_status(@vacation_data)
      end
      @vacation_data.save
    end
    redirect_to edit_holiday_path(@current_user.id), flash: { notice: '保存しました' }
  end

  # ユーザーの有休残日数を減らす
  def reduce_holiday_count(vacation_data)
        user = User.find(vacation_data.applicant_id)
        user.paid_holiday_count -= vacation_data.get_days
        user.save
  end

  # 勤怠状況のステータスを欠勤にする
  def change_attend_status(vacation_data)
        attend_data = AttendanceTime.find_by(user_id: vacation_data.applicant_id ,work_date: vacation_data.get_start_date)
        attend_data.status = 'absence'
        attend_data.save
  end
end
