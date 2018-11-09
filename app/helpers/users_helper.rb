# UsersHelper
module UsersHelper
  module UsersConstant
    WORK_STATUS = [['出勤','work'],['有給休暇','vacation'],['午前休暇','am_vacation'],
                  ['午後休暇','pm_vacation'],['休日出勤','holiday_work'],
                  ['欠勤','absence'],['休日','holiday']].map(&:freeze).freeze
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
