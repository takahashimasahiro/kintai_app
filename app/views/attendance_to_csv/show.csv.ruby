require 'csv'
CSV.generate do |csv|
  csv << %w[日付 曜日 出勤時刻 退勤時刻 稼働時間 休憩時間 残業時間 状態]
  sum_break_time = 0
  sum_orver_time = 0
  sum_work_time = 0
  (1..@first_month.end_of_month.day).each do |row|
    row_date = change_date(@first_month, row)
    select_attend = choice_attendanceTime(@all_attend_data, row_date)
    if select_attend.nil?
      csv <<[
        row_date.strftime('%Y/%m/%d'),
        date_of_week(row_date.wday),
        '00:00',
        '00:00',
        convert_min(0),
        convert_min(0),
        convert_min(0),
        all_status[absence?(row_date)]
      ]
      next
    end
    csv << [
      row_date.strftime('%Y/%m/%d'),
      date_of_week(row_date.wday),
      select_attend.work_start.strftime('%H:%M'),
      select_attend.work_end.strftime('%H:%M'),
      convert_min(calculate_working_time(select_attend, row_date)),
      convert_min(calculate_break_time(select_attend, row_date)),
      convert_min(calculate_over_time(select_attend)),
      all_status[select_attend.status.to_sym]
    ]
    sum_break_time += calculate_break_time(select_attend, row_date)
    sum_orver_time += calculate_over_time(select_attend)
    sum_work_time += calculate_working_time(select_attend, row_date)
  end
  csv << %w[月別合計 ユーザー名 権限 出勤日数 稼働時間 休憩時間 残業時間 有休取得数 残有休数]
  # TODO 休日出勤 欠勤 休日 数を表示
  csv << [
    '',
    @selected_user.name,
    all_role[@selected_user.role.to_sym],
    @all_attend_data.count - @pass_days.count,
    convert_min(sum_work_time),
    convert_min(sum_break_time),
    convert_min(sum_orver_time),
    @pass_days.empty? ? 0 : @pass_days.map{ |x| x[1] }.inject(:+),
    @selected_user.paid_holiday_count]
end