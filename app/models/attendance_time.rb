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
end
