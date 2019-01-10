# UsersHelper
module UsersHelper
  WORK_STATUS = {
    work:         I18n.t(:work_status, scope: %i[helper users])[0],
    vacation:     I18n.t(:work_status, scope: %i[helper users])[1],
    am_vacation:  I18n.t(:work_status, scope: %i[helper users])[2],
    pm_vacation:  I18n.t(:work_status, scope: %i[helper users])[3],
    holiday_work: I18n.t(:work_status, scope: %i[helper users])[4],
    absence:      I18n.t(:work_status, scope: %i[helper users])[5],
    holiday:      I18n.t(:work_status, scope: %i[helper users])[6]
  }.freeze

  def user_select_status(status)
    WORK_STATUS[status] || I18n.t(:undecided, scope: %i[helper users])
  end
end
