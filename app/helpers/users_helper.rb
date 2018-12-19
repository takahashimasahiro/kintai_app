# UsersHelper
module UsersHelper
  WORK_STATUS = {
    work:         I18n.t(:work_status, scope: :attend)[0],
    vacation:     I18n.t(:work_status, scope: :attend)[1],
    am_vacation:  I18n.t(:work_status, scope: :attend)[2],
    pm_vacation:  I18n.t(:work_status, scope: :attend)[3],
    holiday_work: I18n.t(:work_status, scope: :attend)[4],
    absence:      I18n.t(:work_status, scope: :attend)[5],
    holiday:      I18n.t(:work_status, scope: :attend)[6]
  }.freeze

  def user_select_status(status)
    # TODO: i18n
    WORK_STATUS[status] || '未定'
  end
end
