# TODO docをかく
class AttendanceTime < ApplicationRecord
  belongs_to :user

  enum status: {
    work: 'work',
    vacation: 'vacation',
    am_vacation: 'am_vacation',
    pm_vacation: 'pm_vacation',
    holiday_work: 'holiday_work',
    absence: 'absence',
    holiday: 'holiday'
  }

  # 勤怠入力する
  # @param [User] 勤怠登録するユーザー
  # @param [String] 入力ステータス
  def update_attend(selected_user, input_status)
    transaction do

      # 有休申請するときは時間をリセットする
      if !include_vacation?(self.status) && include_vacation?(input_status)
        self.work_start = self.work_start.change(hour: 0, min: 0)
        self.work_end = self.work_end.change(hour: 0, min: 0)
      end

      if include_vacation?(input_status)
        # 有給休暇申請を行う
        ApplyVacation.new.apply_for_vacation(input_status, selected_user, work_date)
      elsif include_vacation?(self.status) && !include_vacation?(input_status)
        # 有休申請取消処理
        ApplyVacation.new.apply_cancel(selected_user, work_date)
      end
      self.status = input_status
      self.save!
    end
  rescue
    raise ActiveRecord::Rollback
  end

  # 休暇申請か判別する
  # @param [String] 入力ステータス
  # @param [Boolean] true:有休(半休含む), false:それ以外
  def include_vacation?(input_status)
    input_status.present? && input_status.include?('vacation')
  end

  # 月初を取得する
  # 引数が正しくない場合は今月の月初を返す
  def self.first_month(year, month)
    if year && month
      Date.new(year.to_i, month.to_i, 1)
    else
      Date.today.change(day: 1)
    end
  end

  # 休暇申請状況をもとに勤怠状況のステータスを変更する
  # param [ApplyVacation] 休暇申請
  # param [symbol] 変更するステータス
  def change_attend_status(vacation, status)
    AttendanceTime.transaction do
      attend_data = AttendanceTime.find_by(user_id: vacation.applicant_id, work_date: vacation.get_start_date)
      attend_data.status = status
      attend_data.save!
    end
  rescue
    raise ActiveRecord::Rollback
  end
end
