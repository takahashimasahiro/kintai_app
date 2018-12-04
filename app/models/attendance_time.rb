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

  # 休暇申請か判別する
  def self.vacation?(status)
    status.present? && status.include?('vacation')
  end

  # 月初を取得する
  def self.first_month(year, month)
    if year && month
      Time.zone.now.change(year: year.to_i, month: month.to_i, day: 1)
    else
      Time.zone.now
    end
  end

  # 勤怠状況のステータスを変更する
  def change_attend_status(vacation, status)
    attend_data = AttendanceTime.find_by(user_id: vacation.applicant_id, work_date: vacation.get_start_date)
    attend_data.status = status
    attend_data.save!
  rescue StandardError => e
    raise e
  end
end
