# frozen_string_literal: true

class ApplyVacation < ApplicationRecord

  validates :applicant_id, presence: true
  validates :get_start_date, presence: true
  validates :get_days, presence: true

  enum status: {
    applying: 'applying', # 申請中
    boss_applied: 'boss_applied', # 上長承認済
    admin_applied: 'admin_applied', # 管理者承認済
    withdrawal: 'withdrawal', # 申請却下(申請者取下げ)
    apply_rejection: 'apply_rejection' # 申請却下(上長または管理者不許可)
  }

  # ユーザーの有休残日数を減らす
  def reduce_holiday_count
    user = User.find(self.applicant_id)
    # TODO: 残有休数が0以下になる場合は欠勤となる処理をかく

    user.paid_holiday_count -= vacation_data.get_days
    user.save!
  end

  # 勤怠状況のステータスを欠勤にする
  def change_attend_status
    attend_data = AttendanceTime.find_by(user_id: self.applicant_id, work_date: self.get_start_date)
    attend_data.absence!
  end
end
