module AttendancesHelper

  module AttendanceConstant
    DATE_OF_WEEK = ["日","月","火","水","木","金","土"].map(&:freeze).freeze
    WORK_STATUS = ['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤'].map(&:freeze).freeze
  end

  def date_of_week(count)
    AttendanceConstant.freeze
    AttendanceConstant::DATE_OF_WEEK[count]
  end

  def work_status
    AttendanceConstant.freeze
    AttendanceConstant::WORK_STATUS
  end
  
  def show_years_map
    (@select_date.year.to_i - 10..@select_date.year.to_i + 10).map{|y| y}
  end

  # 日付を指定して勤怠状況を検索する
  def choice_attendanceTime(attendance_table ,select_date, row)
    attendance_table.select{|x| x.work_date == select_date.change(day: row)}[0]
  end

  def show_start_attendanceTime(attendance_row,row,form)
    if attendance_row
      time_select("work_#{row}", 'start',:default =>
      {:year =>attendance_row.work_date.year ,
        :month => attendance_row.work_date.month,
        :day => row ,
        :hour => attendance_row.work_start.hour,
        :minute => attendance_row.work_start.min })
    else
      time_select("work_#{row}", 'start',:default =>
        {:year => @select_date.year ,
          :month => @select_date.month,
          :day => row ,
          :hour => '10',
          :minute => '00'})
    end
  end

  def show_end_attendanceTime(attendance_row,row,form)
    if attendance_row
      time_select("work_#{row}", 'end',:default =>
        {:year =>attendance_row.work_date.year ,
          :month => attendance_row.work_date.month,
          :day => row ,
          :hour => attendance_row.work_end.hour,
           :minute => attendance_row.work_end.min})
    else
      time_select("work_#{row}", 'end',:default => 
        {:year => @select_date.year ,
        :month => @select_date.month,
        :day => row ,
        :hour => '19', 
        :minute => '00'})
    end
  end

end
