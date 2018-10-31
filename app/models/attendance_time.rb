class AttendanceTime < ApplicationRecord
  belongs_to :user
  enum status: [:work,:vacation,:am_vacation,:pm_vacation,:holiday_work,:absence]
end
