module HolidaysHelper
  module HolidaysConstant
    APPLICATION_STATUS = [%w[applying 申請中], %w[boss_applied 上長承認済],
                          %w[admin_applied 管理者承認済], %w[withdrawal 申請取下],
                          %w[apply_rejection 不許可]].map(&:freeze).freeze
  end

  def application_status
    HolidaysConstant.freeze
    HolidaysConstant::APPLICATION_STATUS
  end

  def select_status(status)
    HolidaysConstant.freeze
    HolidaysConstant::APPLICATION_STATUS.map { |r| r[1] if r[0] == status }.compact[0]
  end
end
