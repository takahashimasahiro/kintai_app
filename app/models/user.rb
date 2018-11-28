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
end
