class AddCommentToApplyVacation < ActiveRecord::Migration[5.2]
  def change
    change_column :apply_vacations, :applied_reason, :string, comment: '申請者の申請理由'
    change_column :apply_vacations, :owner_comment, :string, comment: '管理者コメント'
  end
end
