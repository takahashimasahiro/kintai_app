# frozen_string_literal: true

FactoryBot.define do
  factory :attendance_time do
    user_id(&:to_s)
    work_date { Date.today }
    work_start { DateTime.now }
    work_end { DateTime.now + Rational(9,24)}
    status { 'work' }
  end
end
