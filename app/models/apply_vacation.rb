class ApplyVacation < ApplicationRecord
  belongs_to :applicant, :class_name => 'user', foreign_key: 'id'

  validates :applicant_id, { presence: true }
  validates :get_start_date, { presence: true }
  validates :get_days, { presence: true }

  enum status: {
    applying: 'applying', # 申請中
    boss_applied: 'boss_applied', # 上長承認済
    admin_applied: 'admin_applied', # 管理者承認済
    withdrawal: 'withdrawal', # 申請却下(申請者取下げ)
    apply_rejection: 'apply_rejection' # 申請却下(上長または管理者不許可)
  }
end
