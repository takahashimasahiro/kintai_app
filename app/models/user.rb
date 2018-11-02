class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  has_secure_password

  # https://railsguides.jp/association_basics.html
  has_many :attendance_times, dependent: :destroy

  enum role: {
    part_time_job: 'part_time_job',
    employee: 'employee',
    owner: 'owner'
  }

  def posts
    return Post.where(user_id: self.id)
  end
end
