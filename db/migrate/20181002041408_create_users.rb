class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :email
      t.string :name
      t.string :password
      t.string :role, default: 'employee'
      t.numeric :paid_holiday_count, default: 10
      t.timestamps
    end
  end
end
