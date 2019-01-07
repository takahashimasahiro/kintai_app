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
    User.transaction do
      user = User.find(applicant_id)
      # 有休の前借りも考慮して、一旦残有休数が0以下になっても良い形にする
      # if user.paid_holiday_count >= get_days
      user.paid_holiday_count -= get_days
      change_vacation_status(:admin_applied)
      # else
      #   # 残有休数が0以下になる時は欠勤にする
      #   AttendanceTime.new.change_attend_status(self, :absence)
      #   change_vacation_status(:apply_rejection)
      # end
      user.save!
    end
  rescue StandardError
    raise ActiveRecord::Rollback
  end

  # 申請状況ステータスを変更する
  # @params [Symbol] 入力ステータス
  def change_vacation_status(status)
    ApplyVacation.transaction do
      self.status = status
      save!
    end
  rescue StandardError
    raise ActiveRecord::Rollback
  end

  # 休暇申請をする
  # @param [String] 入力ステータス
  # @param [User] 申請ユーザー
  # @param [Date] 登録日付
  # @param [String] 申請理由
  def apply_for_vacation(status, user, date, user_reason)
    ApplyVacation.transaction do
      vacation = user.apply_vacations.find_or_create_by!(get_start_date: date)
      vacation.get_days = status.start_with?('vacation') ? 1 : 0.5
      vacation.status = :applying
      vacation.applied_reason = user_reason
      vacation.save!
    end
  rescue StandardError
    raise ActiveRecord::Rollback
  end

  # 休暇申請を取り消す
  # @param [User] 申請ユーザー
  # @param [Date] 取消日付
  def apply_cancel(user, date)
    ApplyVacation.transaction do
      vacation = user.apply_vacations.find_by(get_start_date: date, status: :applying)
      vacation.status = :withdrawal
      vacation.save!
    end
  rescue StandardError
    raise ActiveRecord::Rollback
  end
end
