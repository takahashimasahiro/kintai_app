class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    # パスワードの暗号化
    add_column :users, :password_digest, :string
  end
end
