class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  # validates :password, presence: true, length: { minimum: 8 }
  has_secure_password
  
  # https://railsguides.jp/association_basics.html
  has_many :attendancetimes, dependent: :destroy
  def posts
    return Post.where(user_id: self.id)
  end
end
