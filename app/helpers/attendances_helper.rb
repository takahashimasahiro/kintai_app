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
      {
        year: attendance_row.work_date.year,
        month: attendance_row.work_date.month,
        day: date.day,
        hour: attendance_row.work_start.hour,
        minute: attendance_row.work_start.min
      }
    else
      # データがない場合は初期値を作成
      {
        year: date.year,
        month: date.month,
        day: date.day,
        hour: default_start_hour(date),
        minute: '00'
      }
    end
  end

  # 勤務終了時間を表示する
  def show_end_attendanceTime(attendance_row, date)
    if attendance_row
      # データが保存されていた場合それを入力
      {
        year: attendance_row.work_date.year,
        month: attendance_row.work_date.month,
        day: date.day,
        hour: attendance_row.work_end.hour,
        minute: attendance_row.work_end.min
      }
    else
      # データがない場合は初期値を作成
      {
        year: date.year,
        month: date.month,
        day: date.day,
        hour: default_end_hour(date),
        minute: '00'
      }
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

  # 日付を変更する
  def change_date(first_month, row)
    first_month.change(day: row)
  end

  # 日付が含まれているか判別する
  def is_include?(all_pass_days, row_date)
    all_pass_days.select { |x| x[0] == row_date }[0]
  end

  # 実稼働時間を算出する
  # return (min)
  def calculate_working_time(attendance_row, row_date)
    if attendance_row
      # 退勤時間-出勤時間
      hour,sec = (attendance_row.work_end - attendance_row.work_start).divmod(3600)
      # 8時間以上の場合は休憩で-1時間する
      hour -= 1 if hour >= 9
      ( hour * 60 ) + ( sec / 60)
    else
      weekend?(row_date) ? 0 : (8 * 60)
    end
  end

  # 休憩時間を算出する
  # return (min)
  def calculate_break_time(attendance_row, row_date)
    if attendance_row
      hour = ((attendance_row.work_end-attendance_row.work_start)/3600).floor
      if hour >=8
        60
      elsif hour >= 6
        45
      else
        0
      end
    else
      weekend?(row_date) ? 0 : 60
    end
  end

  # 残業時間を算出する
  # return (min)
  def calculate_over_time(attendance_row)
    return 0 if attendance_row.nil?
    # 退勤時間-出勤時間
    hour,sec = (attendance_row.work_end - attendance_row.work_start).divmod(3600)
    if hour >= 9
      hour -= 9
      (sec / 60) + (hour * 60)
    else
      0
    end
  end

  # 分合計を時間+分にする
  # 表示しやすい形に変更する
  def convert_min(min_sum)
    hour,min = min_sum.divmod(60)
    if hour == 0
      "#{min.to_i}分"
    elsif min == 0
      "#{hour.to_i}時間"
    else
      "#{hour.to_i}時間#{min.to_i}分"
    end
  end
end
