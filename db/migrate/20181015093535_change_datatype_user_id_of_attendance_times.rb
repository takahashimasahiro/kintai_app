

class ChangeDatatypeUserIdOfAttendanceTimes < ActiveRecord::Migration[5.2]
  def change
    # サロゲートキー対応
    change_column :attendance_times, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
