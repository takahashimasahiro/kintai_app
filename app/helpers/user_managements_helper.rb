module UserManagementsHelper
  ROLE = {
    owner:         I18n.t(:role, scope: %i[helper user_managements])[0],
    employee:      I18n.t(:role, scope: %i[helper user_managements])[1],
    part_time_job: I18n.t(:role, scope: %i[helper user_managements])[2]
  }.freeze

  def all_role
    ROLE
  end
end
