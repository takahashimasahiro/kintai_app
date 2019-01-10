module HolidaysHelper
  APPLICATION_STATUS = {
    applying:        I18n.t(:application_status, scope: %i[helper holidays])[0],
    boss_applied:    I18n.t(:application_status, scope: %i[helper holidays])[1],
    admin_applied:   I18n.t(:application_status, scope: %i[helper holidays])[2],
    withdrawal:      I18n.t(:application_status, scope: %i[helper holidays])[3],
    apply_rejection: I18n.t(:application_status, scope: %i[helper holidays])[4]
  }.freeze

  def application_status
    APPLICATION_STATUS
  end
end
