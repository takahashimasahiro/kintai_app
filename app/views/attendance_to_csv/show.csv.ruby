require 'csv'
CSV.generate do |csv|
  csv << %w[ユーザー名 日付 曜日 出勤時刻 退勤時刻 状態]

  (1..@first_month.end_of_month.day).each do |row|
    row_date = change_date(@first_month, row)
    select_attend = choice_attendanceTime(@all_attend_data, row_date)
    # TODO: データがない日付はどうするか
    # ユーザー情報を表示する？どういう風に？
    csv << [
      @selected_user.name,
      row_date.strftime('%Y/%m/%d'),
      date_of_week(row_date.wday),
      # select_attend ? select_attend.work_start.strftime('%H:%M') : "00:00",
      select_attend ? select_attend.work_start.strftime('%H:%M') : "#{default_start_hour(row_date)}:00",
      # select_attend ? select_attend.work_end.strftime('%H:%M') : "00:00",
      select_attend ? select_attend.work_end.strftime('%H:%M') : "#{default_end_hour(row_date)}:00",
      # all_status[ select_attend ? select_attend.status.to_sym : absence?(row_date)]
      all_status[select_attend ? select_attend.status.to_sym : work_day?(row_date)]
    ]
  end
end
