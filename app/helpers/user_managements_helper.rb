module UserManagementsHelper
  ROLE = {
    owner: '管理者',
    employee: '社員',
    part_time_job: 'アルバイト'
  }.freeze

  def all_role
    ROLE
  end
end
