class AttendancesController < ApplicationController
  def new
  end

  def show
    # AttendanceConstant.freeze
    
    @today = Date.today
    @lastday = @today.end_of_month.day
    @attendance_table = AttendanceTime.where(:work_date => @today.all_month,user_id: @current_user.id)
  end
  # module AttendanceConstant
  #   @DATE_OF_WEEK = ["日","月","火","水","木","金","土"].map(&:freeze).freeze
  #   @WORK_STATUS = ['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤'].map(&:freeze).freeze
  # end
end