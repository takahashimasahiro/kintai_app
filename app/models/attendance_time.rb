class AttendanceTime < ApplicationRecord
  belongs_to :user

  enum status: {
    work: 'work',
    vacation: 'vacation',
    am_vacation: 'am_vacation',
    pm_vacation: 'pm_vacation',
    holiday_work: 'holiday_work',
    absence: 'absence',
    holiday: 'holiday'
  }

  # 勤怠入力する
  def update_attend(selected_user, input_status)
    transaction do
      # 有休申請するときは時間をリセットする
      if !include_vacation?(self.status) && include_vacation?(input_status)
        self.work_start = self.work_start.change(hour: 0, min: 0)
        self.work_end = self.work_end.change(hour: 0, min: 0)
        p self
      end
      if include_vacation?(input_status)
        # 有給休暇申請を行う
        ApplyVacation.new.apply_for_vacation(input_status, selected_user, work_date)
      elsif include_vacation?(self.status) && !include_vacation?(input_status)
        # 有休申請取消処理
        ApplyVacation.new.apply_cancel(selected_user, work_date)
      end
      # TODO 曜日が土日祝日で出退勤時間を入力された時、休日出勤にする
      self.status = input_status
      self.save!
    end
  rescue SomeError
    raise ActiveRecord::Rollback
  end

  # 休暇申請か判別する
  def include_vacation?(input_status)
    input_status.present? && input_status.include?('vacation')
  end

  # 月初を取得する
  def self.first_month(year, month)
    if year && month
      Date.new(year.to_i, month.to_i, 1)
    else
      Date.today
    end
  end

  # 勤怠状況のステータスを変更する
  def change_attend_status(vacation, status)
    attend_data = AttendanceTime.find_by(user_id: vacation.applicant_id, work_date: vacation.get_start_date)
    attend_data.status = status
    attend_data.save!
  rescue SomeError
    raise ActiveRecord::Rollback
  end
end
