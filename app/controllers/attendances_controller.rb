class AttendancesController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count
  before_action :set_paper_trail_whodunnit

  def show
    # 月初取得
    @first_month = AttendanceTime.first_month(params[:select_year], params[:select_month])
    # ユーザー取得
    @selected_user = User.select_user(params[:select_user], @current_user)
    # 勤怠情報
    @attendance_table = @selected_user.attendance_times.where(work_date: @first_month.all_month).order(:work_date)
    # 全ユーザー(管理者モード)
    @user_all = User.all.order(:id).pluck(:name, :id) if @current_user.owner?
    # 受理された休暇申請
    @pass_days = @selected_user.applied_for_month(@first_month)
    # 有休申請数
    @vacation_count = @selected_user.vacation_count_for_month(@first_month) || 0
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
    if attend.update_attend(@selected_user, params[:change_status], params[:vacation_reason])
      redirect_to attendance_path(@current_user.id), flash: { notice: t(:save_success, scope: :messages) }
    else
      redirect_to attendance_path(@current_user.id), flash: { notice: t(:save_failed, scope: :messages) }
    end
  rescue StandardError => e
    @error_message = e.message
    redirect_to attendance_path(@current_user.id), flash: { notice: t(:save_failed, scope: :messages) }
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
    Time.new(
      params[:select_year].to_i,
      params[:select_month].to_i,
      params[:change_day].to_i,
      params[:change_start_hour].to_i,
      params[:change_start_minute].to_i,
      0
    )
  end

  def work_end_time
    Time.new(
      params[:select_year].to_i,
      params[:select_month].to_i,
      params[:change_day].to_i,
      params[:change_end_hour].to_i,
      params[:change_end_minute].to_i,
      0
    )
  end
end
