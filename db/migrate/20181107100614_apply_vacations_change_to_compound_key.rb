class ApplyVacationsChangeToCompoundKey < ActiveRecord::Migration[5.2]
  def change
    add_index :apply_vacations, [:applicant_id, :get_start_date], unique: true
  end
end
