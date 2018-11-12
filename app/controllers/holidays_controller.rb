class HolidaysController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @my_vacation = @current_user.apply_vacations.all.order(:get_start_date)
  end

  def edit
    @applying_vacation = User.joins(:apply_vacations).where(apply_vacations: {status: 'applying'}).select("apply_vacations.* , users.name ")
  end
  
  def update
    @vacation_data = ApplyVacation.find_by(applicant_id: params[:user_id], get_start_date: params[:get_date])
    if @vacation_data
      @vacation_data.status = params[:button]
      if params[:approve]
        # 許可
        reduce_holiday_count(@vacation_data)
      elsif params[:dismiss]
        # 却下
        change_attend_status(@vacation_data)
      end
      @vacation_data.save
    end
    redirect_to edit_holiday_path(@current_user.id), flash: { notice: '保存しました' }
  end

  # ユーザーの有休残日数を減らす
  def reduce_holiday_count(vacation_data)
        user = User.find(vacation_data.applicant_id)
        # TODO 残有休数が0以下になる場合は欠勤となる処理をかく
        
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
