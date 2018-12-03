# UsersHelper
module UsersHelper
  WORK_STATUS = {
    work:         '出勤',
    vacation:     '有給休暇',
    am_vacation:  '午前休暇',
    pm_vacation:  '午後休暇',
    holiday_work: '休日出勤',
    absence:      '欠勤',
    holiday:      '休日'
  }.freeze

  def user_select_status(status)
    WORK_STATUS[status] || '未定'
  end
end
