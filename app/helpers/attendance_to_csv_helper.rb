module AttendanceToCsvHelper
  include AttendancesHelper

  def absence?(date)
    weekend?(date) ? :holiday : :absence
  end

  def work_day?(date)
    weekend?(date) ? :holiday : :work
  end
end
