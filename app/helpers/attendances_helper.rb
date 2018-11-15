# frozen_string_literal: true

module AttendancesHelper
  module AttendanceConstant
    DATE_OF_WEEK = %w[日 月 火 水 木 金 土].map(&:freeze).freeze
    WORK_STATUS = [%w[出勤 work], %w[有給休暇 vacation], %w[午前休暇 am_vacation],
                   %w[午後休暇 pm_vacation], %w[休日出勤 holiday_work],
                   %w[欠勤 absence], %w[休日 holiday]].map(&:freeze).freeze
    DEFAULT_WORK_START = '10' # 出勤時間
    DEFAULT_WORK_END = '19' # 退勤時間
  end

  def date_of_week(count)
    AttendanceConstant.freeze
    AttendanceConstant::DATE_OF_WEEK[count]
  end

  def work_status
    AttendanceConstant.freeze
    AttendanceConstant::WORK_STATUS
  end

  def create_day_of_week_classname(row)
    holiday?(row) ? 'holiday' : @select_date.change(day: row).wday
  end

  # 年セレクトボックス
  def show_years_map
    (@select_date.year.to_i - 10..@select_date.year.to_i + 10).map { |y| y }
  end

  # 選択した日付の勤怠状況を取得
  def choice_attendanceTime(attendance_table, select_date, row)
    attendance_table.select { |x| x.work_date == Date.new(select_date.year, select_date.month, row) }[0]
  end

  # 勤務開始時間を表示する
  def show_start_attendanceTime(attendance_row, row)
    if attendance_row
      time_select("work_#{row}", 'start', default:       { year: attendance_row.work_date.year,
                                                           month: attendance_row.work_date.month,
                                                           day: row,
                                                           hour: attendance_row.work_start.hour,
                                                           minute: attendance_row.work_start.min })
    else
      time_select("work_#{row}", 'start', default:         { year: @select_date.year,
                                                             month: @select_date.month,
                                                             day: row,
                                                             hour: weekend?(row) ? '00' : AttendanceConstant::DEFAULT_WORK_START,
                                                             minute: '00' })
    end
  end

  # 勤務終了時間を表示する
  def show_end_attendanceTime(attendance_row, row)
    if attendance_row
      time_select("work_#{row}", 'end', default:         { year: attendance_row.work_date.year,
                                                           month: attendance_row.work_date.month,
                                                           day: row,
                                                           hour: attendance_row.work_end.hour,
                                                           minute: attendance_row.work_end.min })
    else
      time_select("work_#{row}", 'end', default:         { year: @select_date.year,
                                                           month: @select_date.month,
                                                           day: row,
                                                           hour: weekend?(row) ? '00' : AttendanceConstant::DEFAULT_WORK_END,
                                                           minute: '00' })
    end
  end

  # 状態の初期選択
  def selected_status(attendance_row, row)
    if attendance_row
      attendance_row.status
    elsif weekend?(row)
      AttendanceConstant::WORK_STATUS.fetch(6)
    else
      AttendanceConstant::WORK_STATUS.fetch(0)
    end
  end

  # 土日祝日か判別する
  def weekend?(row)
    @select_date.change(day: row).wday == 0 || @select_date.change(day: row).wday == 6 || holiday?(row)
  end

  # 祝日か判別する
  def holiday?(row)
    HolidayJapan.check(Date.new(@select_date.year, @select_date.month, row))
  end
end
