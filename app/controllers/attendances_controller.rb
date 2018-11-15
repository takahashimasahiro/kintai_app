# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @select_date = Time.now
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i, day: 1)
    end

    if @current_user.role == 'owner'
      @user_all = User.all.order(:id).pluck(:name, :id)
    end
    @lastday = @select_date.end_of_month.day
    @selected_user =  User.where(id: params[:select_user] || @current_user.id).pluck(:name, :id)[0]
    @attendance_table = User.find(@selected_user[1]).attendance_times.where(work_date: @select_date.all_month)
  end

  def update
    @select_date = Time.now
    if params[:select_year] && params[:select_month]
      @select_date = @select_date.change(year: params[:select_year].to_i, month: params[:select_month].to_i, day: 1)
    end
    @change_rows = params[:change_rows].split(',')
    @change_rows.map do |i|
      # 登録する日付を宣言
      @registration_date = DateTime.new(
        params[:"work_#{i}"]['start(1i)'].to_i,
        params[:"work_#{i}"]['start(2i)'].to_i,
        params[:"work_#{i}"]['start(3i)'].to_i
      )

      # 日付をもとにcreate or update
      @attend = if @current_user.role == 'owner'
                  AttendanceTime.find_or_initialize_by(user_id: params[:select_user], work_date: @registration_date)
                else
                  AttendanceTime.find_or_initialize_by(user_id: @current_user.id, work_date: @registration_date)
      end
      @attend.work_start = DateTime.new(
        params[:"work_#{i}"]['start(1i)'].to_i,
        params[:"work_#{i}"]['start(2i)'].to_i,
        params[:"work_#{i}"]['start(3i)'].to_i,
        params[:"work_#{i}"]['start(4i)'].to_i,
        params[:"work_#{i}"]['start(5i)'].to_i,
        0, '+09:00'
      )
      @attend.work_end = DateTime.new(
        params[:"work_#{i}"]['end(1i)'].to_i,
        params[:"work_#{i}"]['end(2i)'].to_i,
        params[:"work_#{i}"]['end(3i)'].to_i,
        params[:"work_#{i}"]['end(4i)'].to_i,
        params[:"work_#{i}"]['end(5i)'].to_i,
        0, '+09:00'
      )
      # 有給休暇申請を行う？
      if vacation?(params[:"status_#{i}"])
        @vacation = @current_user.apply_vacations.find_or_create_by(get_start_date: @registration_date)
        @vacation.get_days = params[:"status_#{i}"].index('vacation').zero? ? 1 : 0.5
        @vacation.status = 'applying'
        @vacation.save
      end
      # TODO: 有休申請取消処理

      @attend.status = params[:"status_#{i}"]
      @attend.save
    end
    redirect_to attendance_path(@current_user.id), flash: { notice: '保存しました' }
  end

  def vacation?(status)
    !status.blank? && status.index('vacation')
  end
end
