class ApplyVacationChangeAssociation < ActiveRecord::Migration[5.2]
  def up
    change_table :apply_vacations do |t|
      t.belongs_to :applicant, index: true, comment: '申請者ID'
      # t.belongs_to :authorizer, index: true, comment: '承認者ID'
    end
  end

  def down
    change_table :apply_vacations do |t|
      t.integer :applicant_id, comment: '申請者ID'
      # t.integer :authorizer_id, comment: '承認者ID'
    end
  end
end
