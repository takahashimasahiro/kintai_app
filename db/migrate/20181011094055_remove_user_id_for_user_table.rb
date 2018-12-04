

class RemoveUserIdForUserTable < ActiveRecord::Migration[5.2]
  # remove_columnを使うときはchangeよりup/downを使う
  def change
    # サロゲートキー対応:idにまとめる
    remove_column :users, :user_id, :integer
  end
end
