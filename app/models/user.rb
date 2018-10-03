class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  def posts
    return Post.where(user_id: self.id)
  end
end
