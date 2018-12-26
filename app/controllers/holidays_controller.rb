class HolidaysController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  # def show
  #   @my_vacations = @current_user.apply_vacations.all.order(:get_start_date)
  # end

  def edit
    # 有休申請者一覧を表示
    # ユーザー名はUserに入れているためjoinする
    @applying_vacation = User.joins(:apply_vacations)
                             .where(apply_vacations: { status: :applying })
                             .select('apply_vacations.* , users.name ')
  end

  def update
    vacation_data = ApplyVacation.find_by(applicant_id: params[:user_id], get_start_date: params[:get_date])
    vacation_data.status = params[:button]
    raise StandardError if !vacation_data.status
    vacation_data.owner_comment = params[:comment]
    if params[:button] == 'admin_applied'
      # 許可
      vacation_data.reduce_holiday_count
    elsif params[:button] == 'apply_rejection'
      # 却下
      AttendanceTime.new.change_attend_status(vacation_data, :absence)
    end
    vacation_data.save!
    redirect_to edit_holiday_path(@current_user.id), flash: { notice: t(:save_success, scope: :messages) }
  rescue StandardError => e
    @error_message = e.message
    redirect_to edit_holiday_path(@current_user.id), flash: { notice: t(:save_failed, scope: :messages) }
  end
end
