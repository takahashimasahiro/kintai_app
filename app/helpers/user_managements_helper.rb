module UserManagementsHelper
  ROLE = {
    owner:         I18n.t(:role_status, scope: [:activerecord, :attributes, :user])[0],
    employee:      I18n.t(:role_status, scope: [:activerecord, :attributes, :user])[1],
    part_time_job: I18n.t(:role_status, scope: [:activerecord, :attributes, :user])[2]
  }.freeze

  def all_role
    ROLE
  end
end
