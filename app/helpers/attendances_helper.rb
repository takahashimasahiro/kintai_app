module AttendancesHelper

  def date_of_week(count)
    AttendanceConstant.freeze
    AttendanceConstant::DATE_OF_WEEK[count]
  end

  def work_status
    AttendanceConstant.freeze
    AttendanceConstant::WORK_STATUS
  end
  
  def show_years_map
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|y| y}
  end

  # 
  def choice_attendanceTime(attendance_table ,today, row)
    
  end

  module AttendanceConstant
    DATE_OF_WEEK = ["日","月","火","水","木","金","土"].map(&:freeze).freeze
    WORK_STATUS = ['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤'].map(&:freeze).freeze
  end
end
