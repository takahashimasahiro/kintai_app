

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    # ユーザーテーブル
    create_table :users do |t|
      t.string :user_id, comment: 'ユーザーID'
      t.string :email, comment: 'メールアドレス'
      t.string :name, comment: 'ユーザー名'
      t.string :password, comment: 'パスワード'
      t.string :role, default: 'employee', comment: '権限'
      t.numeric :paid_holiday_count, default: 10, comment: '残有休日数'
      t.timestamps
    end
  end
end
