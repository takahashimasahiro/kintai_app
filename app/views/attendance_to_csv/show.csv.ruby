require 'csv'
CSV.generate do |csv|
  csv << %w[日付 曜日 出勤時刻 退勤時刻 稼働時間 休憩時間 状態]
  sum_break_time = 0
  sum_work_time = 0
  absence_count = 0
  (1..@first_month.end_of_month.day).each do |row|
    row_date = change_date(@first_month, row)
    select_attend = choice_attendanceTime(@all_attend_data, row_date)
    if select_attend.nil?
      csv << [
        row_date.strftime('%Y/%m/%d'),
        date_of_week(row_date.wday),
        '00:00',
        '00:00',
        convert_min(0),
        convert_min(0),
        all_status[absence?(row_date)]
      ]
      absence_count += 1 if absence?(row_date) == :absence
      next
    end
    csv << [
      row_date.strftime('%Y/%m/%d'),
      date_of_week(row_date.wday),
      select_attend.work_start.strftime('%H:%M'),
      select_attend.work_end.strftime('%H:%M'),
      convert_min(calculate_working_time(select_attend, row_date)),
      convert_min(calculate_break_time(select_attend, row_date)),
      all_status[select_attend.status.to_sym]
    ]
    sum_break_time += calculate_break_time(select_attend, row_date)
    sum_work_time += calculate_working_time(select_attend, row_date)
    absence_count += 1 if select_attend.status.to_sym == :absence
  end
  csv << %w[月別合計 ユーザー名 権限 出勤日数 稼働時間合計 休憩時間合計 有休取得数 休日出勤 欠勤 休日 残有休数]
  csv << [
    '',
    @selected_user.name, # ユーザー名
    all_role[@selected_user.role.to_sym], # 権限
    @all_attend_data.select { |data| data.status == 'work' }.count, # 出勤日数
    convert_min(sum_work_time), # 稼働時間合計
    convert_min(sum_break_time), # 休憩時間合計
    @vacation_count, # 有休取得数
    @all_attend_data.select { |data| data.status == 'holiday_work' }.count, # 休日出勤
    absence_count, # 欠勤
    month_holiday_count(@first_month), # 休日
    @selected_user.paid_holiday_count
  ] # 残有休数
end
