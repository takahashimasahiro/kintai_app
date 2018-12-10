class AttendancesController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    # 月初取得
    @first_month = AttendanceTime.first_month(params[:select_year], params[:select_month])
    # ユーザー取得
    @selected_user = User.select_user(params[:select_user], @current_user)
    # 勤怠情報
    @attendance_table = @selected_user.attendance_times.where(work_date: @first_month.all_month)
    # 全ユーザー(管理者モード)
    @user_all = User.all.order(:id).pluck(:name, :id) if @current_user.owner?
    # 受理された休暇申請
    @pass_days = @selected_user.applied_for_month(@first_month)
  end

  def update
    # 月初取得
    @first_month = AttendanceTime.first_month(params[:select_year], params[:select_month])
    # ユーザー取得
    @selected_user = User.select_user(params[:select_user], @current_user)
    # 受理された休暇申請
    @pass_days = @selected_user.applied_for_month(@first_month)
    attend = AttendanceTime.find_or_initialize_by(user_id: @selected_user.id, work_date: registration_date)
    attend.work_start = work_start_time
    attend.work_end = work_end_time
    # 勤怠入力
    if attend.update_attend(@selected_user, params[:change_status])
      redirect_to attendance_path(@current_user.id), flash: { notice: '保存しました' }
    else
      redirect_to attendance_path(@current_user.id), flash: { notice: '保存に失敗しました' }
    end
  rescue SomeError => e
    @error_message = e.message
    redirect_to attendance_path(@current_user.id), flash: { notice: '保存に失敗しました' }
  end

private

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
      params[:change_end_minute].to_i,
      0, '+09:00'
    )
  end
end
