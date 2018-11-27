# frozen_string_literal: true

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
    user = User.find(self.applicant_id)
    if user.paid_holiday_count < self.get_days
      change_attend_status
    else
      user.paid_holiday_count -= self.get_days
    end
    user.save!
  end

  # 勤怠状況のステータスを欠勤にする
  def change_attend_status
    begin
      attend_data = AttendanceTime.find_by(user_id: self.applicant_id, work_date: self.get_start_date)
      attend_data.absence
      attend_data.save!
    rescue => e
      raise e
    end
  end

  # 休暇申請をする
  def apply_for_vacation(status, user, date)
    begin
      ApplyVacation.transaction do
        if AttendanceTime::vacation?(status)
          vacation = user.apply_vacations.find_or_create_by!(get_start_date: date)
          vacation.get_days = status.start_with?('vacation') ? 1 : 0.5
          vacation.status = :applying
          vacation.save!
        end
      end
    rescue Error => e
      raise ActiveRecord::Rollback
      # TODO:例外処理
    end
  end

  # 休暇申請を取り消す
  def apply_cancel(user, date)
    begin
      ApplyVacation.transaction do
        vacation = user.apply_vacations.find_by(get_start_date: date, status: :applying)
        vacation.withdrawal
        vacation.save!
      end
    rescue => e
      raise ActiveRecord::Rollback
      # TODO:例外処理
    end
  end
end
