# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  # https://railsguides.jp/association_basics.html
  has_many :attendance_times, dependent: :destroy
  has_many :apply_vacations, foreign_key: 'applicant_id', dependent: :destroy

  enum role: {
    part_time_job: 'part_time_job',
    employee: 'employee',
    owner: 'owner'
  }

  def posts
    Post.where(user_id: id)
  end
end
