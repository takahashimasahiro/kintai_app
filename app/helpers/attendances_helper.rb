# TODO: docをかく
module AttendancesHelper
  WORK_STATUS = {
    not_work: '未出勤',
    work:         I18n.t(:work_status, scope: %i[helper attendances])[0],
    vacation:     I18n.t(:work_status, scope: %i[helper attendances])[1],
    am_vacation:  I18n.t(:work_status, scope: %i[helper attendances])[2],
    pm_vacation:  I18n.t(:work_status, scope: %i[helper attendances])[3],
    holiday_work: I18n.t(:work_status, scope: %i[helper attendances])[4],
    absence:      I18n.t(:work_status, scope: %i[helper attendances])[5],
    holiday:      I18n.t(:work_status, scope: %i[helper attendances])[6]
  }.freeze

  # TODO: デフォルト値の設定
  DEFAULT_WORK_START = 0 # 出勤時間(hour)
  DEFAULT_WORK_END = 0 # 退勤時間(hour)

  def all_status
    WORK_STATUS
  end

  # 日付、ステータス別で各行の背景色を変える
  # @param  [Date]
  # @param  [String, Symbol]
  # @return [String]
  def create_day_of_week_classname(date, select_status, pass_days)
    if holiday?(date)
      # TODO: statusを確認してholidayならこの処理に入れる
      # 現状平日にholidayを表示させてないので、実相時は要検討
      # 管理者のみの制約が必要では？
      'holiday'
    elsif select_status[1].to_s.include?('vacation')
      # TODO: holiday?(date) == true でもstatusがholiday_workならこの処理に入れたい
      pass_days.select { |x| x[0] == date }[0] ? 'approved' : 'not_approved'
    else
      date.wday.to_s
    end
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
        minute: 0
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
        minute: 0
      }
    end
  end

  # デフォルトの出勤時間を取得する
  def default_start_hour(date)
    weekend?(date) ? 0 : DEFAULT_WORK_START
  end

  # デフォルトの退勤時間を取得する
  def default_end_hour(date)
    weekend?(date) ? 0 : DEFAULT_WORK_END
  end

  # 状態の初期選択
  def selected_status(attendance_row, date)
    if attendance_row
      [all_status[attendance_row.status.to_sym], attendance_row.status.to_sym]
    elsif weekend?(date)
      [all_status[:holiday], :holiday]
    else
      [all_status[:not_work], :not_work]
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

  # 休日数を算出する
  def month_holiday_count(first_month)
    first_month.all_month.select { |x| weekend?(x) }.count
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
  # @return [Integer] (min)
  def calculate_working_time(attendance_row, row_date)
    if attendance_row
      # 退勤時間-出勤時間
      hour, sec = if attendance_row.work_end < attendance_row.work_start
                    ((attendance_row.work_end + (24 * 3600)) - attendance_row.work_start).divmod(3600)
                  else
                    (attendance_row.work_end - attendance_row.work_start).divmod(3600)
                  end
      # 8時間以上の場合は休憩で-1時間する
      hour -= 1 if hour >= 8
      ((hour * 60) + (sec / 60)).to_i
    else
      weekend?(row_date) ? 0 : ((DEFAULT_WORK_END - DEFAULT_WORK_START) * 60)
    end
  end

  # 休憩時間を算出する
  # @param [AttendanceTime] 勤怠情報
  # @param [Date] 日付
  # @return [Integer] (min)
  def calculate_break_time(attend, row_date)
    hour = if attend
             dif = (attend.work_end - attend.work_start)
             ((dif < 0 ? dif + (24 * 3600) : dif) / 3600).floor
           else
             return 0 if weekend?(row_date)

             ((DEFAULT_WORK_END - DEFAULT_WORK_START) * 60)
            end

    if hour >= 8
      60
    elsif hour >= 6
      45
    else
      0
    end
  end

  # 残業時間を算出する
  # @param  [AttendanceTime] 勤怠情報
  # @return [Integer] (min)
  def calculate_over_time(attendance_row)
    return 0 if attendance_row.nil?

    # 退勤時間-出勤時間
    hour, sec = (attendance_row.work_end - attendance_row.work_start).divmod(3600)
    if hour >= 9
      hour -= 9
      ((sec / 60) + (hour * 60)).to_i
    else
      0
    end
  end

  # 表示しやすい形に変更する
  # @param [Integer] min
  # @return [String] hh時間mm分
  def convert_min(min_sum)
    hour, min = min_sum.divmod(60)
    if hour == 0
      I18n.t(:other, scope: %i[datetime distance_in_words x_minutes], count: min)
    elsif min == 0
      I18n.t(:other, scope: %i[time hours], count: hour)
    else
      I18n.t(:other, scope: %i[time hours], count: hour) + I18n.t(:other, scope: %i[datetime distance_in_words x_minutes], count: min)
    end
  end

  # 日付から平日休日を判別し、表示させる状態を返却する
  def days_statuses(date)
    statuses = []
    if holiday?(date)
      all_status.each_pair do |key, _val|
        statuses += [key, value] if key == :holiday_work || key == :holiday
      end
    else
      all_status.each_pair do |key, _val|
        if key == :work || key == :vacation || key == :am_vacation || key == :pm_vacation || key == :absence
          statuses += [key, value]
        end
      end
    end
    statuses
  end

  # 平日休日で表示するstatusを変える(平日に休出を出すのはよくない)
  def statuses_by_holiday(attend, date)
    if holiday?(date) || weekend?(date)
      {
        holiday: all_status[:holiday],
        holiday_work: all_status[:holiday_work]
      }.invert
    elsif attend
      {
        work: all_status[:work],
        vacation: all_status[:vacation],
        am_vacation: all_status[:am_vacation],
        pm_vacation: all_status[:pm_vacation],
        absence: all_status[:absence]
      }.invert
    else
      {
        not_work: '未出勤',
        work: all_status[:work],
        vacation: all_status[:vacation],
        am_vacation: all_status[:am_vacation],
        pm_vacation: all_status[:pm_vacation],
        absence: all_status[:absence]
      }.invert
    end
  end
end
