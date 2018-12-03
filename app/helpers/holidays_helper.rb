module HolidaysHelper
  APPLICATION_STATUS = {
    applying: '申請中',
    boss_applied: '上長承認済',
    admin_applied: '管理者承認済',
    withdrawal: '申請取下',
    apply_rejection: '不許可'
  }.freeze

  def application_status
    APPLICATION_STATUS
  end

  def select_status(status)
    APPLICATION_STATUS[status]
  end
end
