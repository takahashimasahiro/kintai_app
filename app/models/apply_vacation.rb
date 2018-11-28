class ApplyVacation < ApplicationRecord
  validates :applicant_id, presence: true
  validates :get_start_date, presence: true

  enum status: {
    applying: 'applying', # 申請中
    boss_applied: 'boss_applied', # 上長承認済
    admin_applied: 'admin_applied', # 管理者承認済
    withdrawal: 'withdrawal', # 申請却下(申請者取下げ)
    apply_rejection: 'apply_rejection' # 申請却下(上長または管理者不許可)
  }

  # ユーザーの有休残日数を減らす
  def reduce_holiday_count
    user = User.find(applicant_id)
    if user.paid_holiday_count < self.get_days
      change_attend_status(:absence)
    else
      user.paid_holiday_count -= self.get_days
      change_attend_status(:admin_applied)
    end
    user.save!
  end

  # 勤怠状況のステータスを変更する
  def change_attend_status(status)
    attend_data = AttendanceTime.find_by(user_id: applicant_id, work_date: get_start_date)
    attend_data.status = status
    attend_data.save!
  rescue StandardError => e
    raise e
  end

  # 休暇申請をする
  def apply_for_vacation(status, user, date)
    ApplyVacation.transaction do
      if AttendanceTime.vacation?(status)
        vacation = user.apply_vacations.find_or_create_by!(get_start_date: date)
        vacation.get_days = status.start_with?('vacation') ? 1 : 0.5
        vacation.status = :applying
        vacation.save!
      end
    end
  rescue SomeError
    raise ActiveRecord::Rollback
    # TODO: 例外処理
  end

  # 休暇申請を取り消す
  def apply_cancel(user, date)
    ApplyVacation.transaction do
      vacation = user.apply_vacations.find_by(get_start_date: date, status: :applying)
      vacation.status = :withdrawal
      vacation.save!
    end
  rescue SomeError
    raise ActiveRecord::Rollback
    # TODO: 例外処理
  end
end
