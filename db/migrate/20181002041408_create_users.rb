class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    # ユーザーテーブル
    create_table :users do |t|
      # ID
      t.string :user_id
      # email
      t.string :email
      # ユーザー名
      t.string :name
      # パスワード
      t.string :password
      # 権限: デフォルト社員
      t.string :role, default: 'employee'
      # 残有休数: 一旦初期値を10に
      t.numeric :paid_holiday_count, default: 10
      t.timestamps
    end
  end
end
