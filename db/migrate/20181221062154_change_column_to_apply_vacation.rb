class ChangeColumnToApplyVacation < ActiveRecord::Migration[5.2]
  def change
    rename_column :apply_vacations, :memo, :applied_reason
    add_column :apply_vacations, :owner_comment, :string
  end
end
