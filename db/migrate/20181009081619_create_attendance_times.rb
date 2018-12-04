

class CreateAttendanceTimes < ActiveRecord::Migration[5.2]
  def change
    # 勤怠時間テーブル
    create_table :attendance_times do |t|
      t.string :user_id, comment: 'ユーザーID'
      t.date :work_date, comment: '勤怠日付'
      t.time :work_start, comment: '出勤時間'
      t.time :work_end, comment: '退勤時間'
      t.string :status, comment: '勤怠状況'
      t.timestamps
    end
  end
end
