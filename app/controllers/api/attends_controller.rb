class Api::AttendsController < ApplicationController
  def edit
    # TODO: user認証
    user = User.find(params[:id])
    update_date = params[:work_date] ? Date.strptime(params[:work_date], '%Y-%m-%d') : Date.today
    # TODO: 時刻のフォーマットはクライアント側を見て調整
    attend_time = params[:work_start] ? DateTime.strptime(params[:work_start], '%H:%M') : DateTime.now
    attend = AttendanceTime.find_or_create_by(user_id: user.id, work_date: update_date)
    attend.work_start = attend_time
    attend.work_end = Time.new(0) unless attend.work_end
    attend.status = 'work' unless attend.status
    attend.save
    render json: attend
  end

  def update
    # render json: [] unless params[:id]
    # TODO: user認証
    user = User.find(params[:id])
    update_date = params[:work_date] ? Date.strptime(params[:work_date], '%Y-%m-%d') : Date.today
    # TODO: 時刻のフォーマットはクライアント側を見て調整
    attend_time = params[:work_start] ? DateTime.strptime(params[:work_start], '%H:%M') : DateTime.now
    attend = AttendanceTime.find_or_create_by(user_id: user.id, work_date: update_date)
    attend.work_start = attend_time
    attend.work_end = Time.new(0)
    attend.status = 'work' unless attend.status
    attend.save
    render json: attend
  end
end
