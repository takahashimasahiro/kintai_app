class AddColumnToApplyVacation < ActiveRecord::Migration[5.2]
  def change
    add_column :apply_vacations, :memo, :string
  end
end
