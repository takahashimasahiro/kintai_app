class ApplyVacation < ApplicationRecord
  enum status: {
    applying: 'applying', # 申請中
    boss_applied: 'boss_applied', # 上長承認済
    admin_applied: 'admin_applied', # 管理者承認済
    withdrawal: 'withdrawal', # 申請却下(申請者取下げ)
    reject: 'reject' # 申請却下(上長または管理者不許可)
  }
end
