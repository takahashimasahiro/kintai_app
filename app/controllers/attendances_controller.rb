class AttendancesController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @select_date = AttendanceTime.first_month(params[:select_year], params[:select_month])
    @selected_user = User.select_user(params[:select_user], @current_user)
    @attendance_table = User.find(@selected_user.id).attendance_times.where(work_date: @select_date.all_month)
    @user_all = User.all.order(:id).pluck(:name, :id) if @current_user.owner?
    @lastday = @select_date.end_of_month.day
  end

  def update
    # 月初取得
    @select_date = AttendanceTime.first_month(params[:select_year], params[:select_month])
    # 取得日
    work_date = registration_date
    # ユーザー取得
    @selected_user = User.select_user(params[:select_user], @current_user)

    AttendanceTime.transaction do
      attend = AttendanceTime.find_or_initialize_by(
        user_id: @selected_user.id,
        work_date: work_date
      )
      attend.work_start = work_start_time
      attend.work_end = work_end_time

      # 有給休暇申請を行う
      ApplyVacation.new.apply_for_vacation(params[:change_status], @selected_user, work_date)
      # 有休申請取消処理
      if AttendanceTime.vacation?(attend.status) && !AttendanceTime.vacation?(params[:change_status])
        ApplyVacation.new.apply_cancel(@selected_user, work_date)
      end
      attend.status = params[:change_status]
      attend.save!
    end
    redirect_to attendance_path(@current_user.id), flash: { notice: '保存しました' }
  rescue SomeError
    raise ActiveRecord::Rollback
  end

  def registration_date
    DateTime.new(
      params[:select_year].to_i,
      params[:select_month].to_i,
      params[:change_day].to_i
    )
  end

  def work_start_time
    DateTime.new(
      params[:select_year].to_i,
      params[:select_month].to_i,
      params[:change_day].to_i,
      params[:change_start_hour].to_i,
      params[:change_start_minute].to_i,
      0, '+09:00'
    )
  end

  def work_end_time
    DateTime.new(
      params[:select_year].to_i,
      params[:select_month].to_i,
      params[:change_day].to_i,
      params[:change_end_hour].to_i,
      params[:change_end_mitute].to_i,
      0, '+09:00'
    )
  end
end
