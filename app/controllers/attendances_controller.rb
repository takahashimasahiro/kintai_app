# TODO: スコープの見直し
class AttendancesController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @select_date = AttendanceTime.first_month(params[:select_year], params[:select_month])
    @user_all = User.all.order(:id).pluck(:name, :id) if @current_user.owner?
    @lastday = @select_date.end_of_month.day
    @selected_user = User.select_user(params[:select_user], @current_user)
    @attendance_table = User.find(@selected_user.id).attendance_times.where(work_date: @select_date.all_month)
  end

  def update
    @select_date = AttendanceTime.first_month(params[:select_year], params[:select_month])
    row = params[:change_rows]

    # 取得日
    @registration_date = registration_date(row)

    # ユーザー取得
    @selected_user = User.select_user(params[:select_user], @current_user)

    # transaction処理
    AttendanceTime.transaction do
      # ID,日付をもとにcreate or update
      @attend = AttendanceTime.find_or_initialize_by(
        user_id: @selected_user.id,
        work_date: @registration_date
      )
      @attend.work_start = work_start_time(row)
      @attend.work_end = work_end_time(row)

      # 有給休暇申請を行う
      ApplyVacation.new.apply_for_vacation(params[:"status_#{row}"], @selected_user, @registration_date)

      # 有休申請取消処理
      if AttendanceTime.vacation?(@attend.status) &&
         !AttendanceTime.vacation?(params[:"status_#{row}"])
        ApplyVacation.new.apply_cancel(@selected_user, @registration_date)
      end

      @attend.status = params[:"status_#{row}"]
      @attend.save!
    end
    redirect_to attendance_path(@current_user.id), flash: { notice: '保存しました' }
  rescue SomeError
    raise ActiveRecord::Rollback
    # TODO: 例外処理
  end

  def registration_date(row)
    DateTime.new(
      params[:"work_#{row}"]['start(1i)'].to_i,
      params[:"work_#{row}"]['start(2i)'].to_i,
      params[:"work_#{row}"]['start(3i)'].to_i
    )
  end

  def work_start_time(row)
    DateTime.new(
      params[:"work_#{row}"]['start(1i)'].to_i,
      params[:"work_#{row}"]['start(2i)'].to_i,
      params[:"work_#{row}"]['start(3i)'].to_i,
      params[:"work_#{row}"]['start(4i)'].to_i,
      params[:"work_#{row}"]['start(5i)'].to_i,
      0, '+09:00'
    )
  end

  def work_end_time(row)
    DateTime.new(
      params[:"work_#{row}"]['end(1i)'].to_i,
      params[:"work_#{row}"]['end(2i)'].to_i,
      params[:"work_#{row}"]['end(3i)'].to_i,
      params[:"work_#{row}"]['end(4i)'].to_i,
      params[:"work_#{row}"]['end(5i)'].to_i,
      0, '+09:00'
    )
  end
end
