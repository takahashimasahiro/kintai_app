class AttendanceToCsvController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @select_date = AttendanceTime.first_month(params[:select_year], params[:select_month])
    @selected_user = User.select_user(params[:select_user], @current_user)
    @all_attend_data = User.find(@selected_user.id).attendance_times.where(work_date: @select_date.all_month).order(:work_date)
    # ファイル名変更
    respond_to do |f|
      f.csv do
        send_data render_to_string, filename: "#{@selected_user.name}_#{DateTime.now.strftime('%Y%m%d%H%M%S')}.csv"
      end
    end
  end
end
