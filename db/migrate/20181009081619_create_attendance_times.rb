class CreateAttendanceTimes < ActiveRecord::Migration[5.2]
  def change
    # 勤怠時間テーブル
    create_table :attendance_times do |t|
      # ユーザーID
      t.string :user_id
      # 日付
      t.date :work_date
      # 出勤時間
      t.time :work_start
      # 退勤時間
      t.time :work_end
      # 勤怠状況
      t.string :status
      t.timestamps
    end
  end
end
