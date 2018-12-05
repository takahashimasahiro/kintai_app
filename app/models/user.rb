class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :attendance_times, dependent: :destroy
  has_many :apply_vacations, foreign_key: 'applicant_id', dependent: :destroy

  enum role: {
    part_time_job: 'part_time_job',
    employee: 'employee',
    owner: 'owner'
  }

  # 選択したユーザーの情報を取得する
  def self.select_user(select_user_id, user)
    User.find(user.owner? && select_user_id ? select_user_id : user.id)
  end

  # ユーザーの一ヶ月間で休暇申請が通った日付を返却
  def applied_for_month(first_month)
    apply_vacations.where(get_start_date: first_month.all_month,
                          status: :admin_applied)
                   .order(:get_start_date)
                   .pluck(:get_start_date)
  end
end
