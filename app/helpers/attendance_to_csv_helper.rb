module AttendanceToCsvHelper
  include AttendancesHelper

  def absence?(row)
    weekend?(row) ? :holiday : :absence
  end

  def work_day?(row)
    weekend?(row) ? :holiday : :work
  end
end
