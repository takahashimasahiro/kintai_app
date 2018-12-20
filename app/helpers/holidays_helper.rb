module HolidaysHelper
  APPLICATION_STATUS = {
    applying:        I18n.t(:apply_status, scope: :apply)[0],
    boss_applied:    I18n.t(:apply_status, scope: :apply)[1],
    admin_applied:   I18n.t(:apply_status, scope: :apply)[2],
    withdrawal:      I18n.t(:apply_status, scope: :apply)[3],
    apply_rejection: I18n.t(:apply_status, scope: :apply)[4]
  }.freeze

  def application_status
    APPLICATION_STATUS
  end
end
