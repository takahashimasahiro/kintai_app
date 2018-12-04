require 'csv'
p 'CSV出力'
CSV.generate do |csv|
  csv << %w[ユーザー名 日付 曜日 出勤時刻 退勤時刻 状態]

  (1..@select_date.end_of_month.day).each do |row|
    select_date = Date.new(@select_date.year, @select_date.month, row)
    select_attend = choice_attendanceTime(@all_attend_data, @select_date, row)
    # TODO: データがない日付はどうするか
    csv << [
      @selected_user.name,
      select_date.strftime('%Y/%m/%d'),
      date_of_week(select_date.wday),
      # select_attend ? select_attend.work_start.strftime('%H:%M') : "00:00",
      select_attend ? select_attend.work_start.strftime('%H:%M') : "#{default_start_hour(row)}:00",
      # select_attend ? select_attend.work_end.strftime('%H:%M') : "00:00",
      select_attend ? select_attend.work_end.strftime('%H:%M') : "#{default_end_hour(row)}:00",
      # work_status( select_attend ? select_attend.status.to_sym : absence?(row))
      work_status(select_attend ? select_attend.status.to_sym : work_day?(row))
    ]
  end
end
