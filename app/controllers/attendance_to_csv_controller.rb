class AttendanceToCsvController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def index
    @first_month = AttendanceTime.first_month(params[:select_year], params[:select_month])
    @all_user = User.all
    @selected_user = User.select_user(1, @current_user)
    # ファイル名変更
    respond_to do |f|
      f.csv do
        send_data render_to_string, filename: "all_user_#{DateTime.now.strftime('%Y%m%d%H%M%S')}.csv"
      end
    end
  end

  def show
    @first_month = AttendanceTime.first_month(params[:select_year], params[:select_month])
    @selected_user = User.select_user(params[:select_user], @current_user)
    @all_attend_data = User.find(@selected_user.id).attendance_times.where(work_date: @first_month.all_month).order(:work_date)
    # 有休申請数
    @vacation_count = @selected_user.vacation_count_for_month(@first_month) || 0
    # ファイル名変更
    respond_to do |f|
      f.csv do
        send_data render_to_string, filename: "#{@selected_user.name}_#{DateTime.now.strftime('%Y%m%d%H%M%S')}.csv"
      end
    end
  end
end
