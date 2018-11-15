# frozen_string_literal: true

# UsersHelper
module UsersHelper
  module UsersConstant
    WORK_STATUS = [%w[出勤 work], %w[有給休暇 vacation], %w[午前休暇 am_vacation],
                   %w[午後休暇 pm_vacation], %w[休日出勤 holiday_work],
                   %w[欠勤 absence], %w[休日 holiday]].map(&:freeze).freeze
  end

  def user_select_status(status)
    UsersConstant.freeze
    value = UsersConstant::WORK_STATUS.map { |r| r[0] if r[1] == status }.compact
    if value.empty?
      '未定'
    else
      value[0]
    end
  end
end
