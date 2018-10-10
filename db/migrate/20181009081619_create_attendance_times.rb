class CreateAttendanceTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_times do |t|
      t.string :user_id
      t.date :work_date
      t.time :work_start
      t.time :work_end
      t.string :status

      t.timestamps
    end
  end
end
