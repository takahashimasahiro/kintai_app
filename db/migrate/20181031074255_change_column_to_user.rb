

class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :role, :string, default: '0'
  end

  def down
    change_column :users, :role, :string, default: 'employee'
  end
end
