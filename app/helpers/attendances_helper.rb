module AttendancesHelper
  DATE_OF_WEEK = %w[日 月 火 水 木 金 土].map(&:freeze).freeze
  WORK_STATUS = {
    'work':         '出勤',
    'vacation':     '有給休暇',
    'am_vacation':  '午前休暇',
    'pm_vacation':  '午後休暇',
    'holiday_work': '休日出勤',
    'absence':      '欠勤',
    'holiday':      '休日'
  }.freeze
  DEFAULT_WORK_START = '10'.freeze # 出勤時間
  DEFAULT_WORK_END = '19'.freeze # 退勤時間

  def date_of_week(count)
    DATE_OF_WEEK[count]
  end

  def all_status
    WORK_STATUS
  end

  def create_day_of_week_classname(date)
    holiday?(date) ? 'holiday' : date.wday
  end

  # 年セレクトボックス
  def show_years_map(date)
    (date.year.to_i - 10..date.year.to_i + 10).map { |y| y }
  end

  # 選択した日付の勤怠状況を取得
  def choice_attendanceTime(attendance_table, date)
    attendance_table.select { |x| x.work_date == date }[0]
  end

  # 勤務開始時間を表示する
  def show_start_attendanceTime(attendance_row, date)
    if attendance_row
      # データが保存されていた場合それを入力
      time_select("work_#{date.day}", 'start', default: { year: attendance_row.work_date.year,
                                                          month: attendance_row.work_date.month,
                                                          day: date.day,
                                                          hour: attendance_row.work_start.hour,
                                                          minute: attendance_row.work_start.min })
    else
      # データがない場合は初期値を作成
      time_select("work_#{date.day}", 'start', default: { year: date.year,
                                                          month: date.month,
                                                          day: date.day,
                                                          hour: default_start_hour(date),
                                                          minute: '00' })
    end
  end

  # 勤務終了時間を表示する
  def show_end_attendanceTime(attendance_row, date)
    if attendance_row
      # データが保存されていた場合それを入力
      time_select("work_#{date.day}", 'end', default: { year: attendance_row.work_date.year,
                                                        month: attendance_row.work_date.month,
                                                        day: date.day,
                                                        hour: attendance_row.work_end.hour,
                                                        minute: attendance_row.work_end.min })
    else
      # データがない場合は初期値を作成
      time_select("work_#{date.day}", 'end', default: { year: date.year,
                                                        month: date.month,
                                                        day: date.day,
                                                        hour: default_end_hour(date),
                                                        minute: '00' })
    end
  end

  # デフォルトの出勤時間を取得する
  def default_start_hour(date)
    weekend?(date) ? '00' : DEFAULT_WORK_START
  end

  # デフォルトの退勤時間を取得する
  def default_end_hour(date)
    weekend?(date) ? '00' : DEFAULT_WORK_END
  end

  # 状態の初期選択
  def selected_status(attendance_row, date)
    if attendance_row
      attendance_row.status
    elsif weekend?(date)
      [all_status[:holiday], :holiday]
    else
      [all_status[:work], :work]
    end
  end

  # 土日祝日か判別する
  def weekend?(date)
    date.wday == 0 || date.wday == 6 || holiday?(date)
  end

  # 祝日か判別する
  def holiday?(date)
    HolidayJapan.check(date)
  end

  def change_date(first_month, row)
    first_month.change(day: row)
  end

  def is_include?(all_pass_days, row_date)
    all_pass_days.select { |x| x == row_date }[0]
  end
end
