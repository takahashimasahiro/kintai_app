class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :attendance_times, dependent: :destroy
  has_many :apply_vacations, foreign_key: 'applicant_id', dependent: :destroy

  enum role: {
    part_time_job: 'part_time_job',
    employee: 'employee',
    owner: 'owner'
  }

  # 管理者の場合は選択したユーザーの情報を取得する
  # それ以外の場合は自分のユーザー情報を取得する
  # @param [Integer] 取得するユーザーID
  # @param [User] 取得したいユーザー本人
  def self.select_user(select_user_id, user)
    User.find(user.owner? && select_user_id ? select_user_id : user.id)
  end

  # ユーザーの一ヶ月間で休暇申請が通った日付を返却
  # @param  [Date] 取得する年月の月初の日付
  # @return [Date, numeric] 休暇申請の承諾された日付と日数
  def applied_for_month(first_month)
    apply_vacations.where(get_start_date: first_month.all_month,
                          status: :admin_applied)
                   .order(:get_start_date)
                   .pluck(:get_start_date, :get_days)
  end

  # ユーザーが申請した休暇申請の総計を取得
  # @param  [Date] 取得する年月の月初の日付
  # @return [numeric]
  def vacation_count_for_month(first_month)
    attendance_times.where(work_date: first_month.all_month)
                    .where('status LIKE ?', '%vacation%')
                    .pluck(:status)
                    .map { |x| x.eql?('vacation') ? 1 : 0.5 }.inject(:+)
  end
end
