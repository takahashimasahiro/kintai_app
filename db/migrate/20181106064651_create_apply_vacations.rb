class CreateApplyVacations < ActiveRecord::Migration[5.2]
  def change
    create_table :apply_vacations do |t|
      t.integer :applicant_id, comment: '申請者ID'
      t.date :get_start_date, comment: '取得開始日'
      t.numeric :get_days, comment: '取得日数'
      t.integer :authorizer_id, comment: '承認者ID'
      t.string :status, default: 'applying', comment: '申請状態'
      t.timestamps
    end
  end
end
