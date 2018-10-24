class RemovePasswordToUsers < ActiveRecord::Migration[5.2]
  def change
    # 暗号化していないパスワードの削除
    remove_column :users, :password, :string
  end
end
