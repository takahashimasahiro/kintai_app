FactoryBot.define do
  factory :attendance_time do
    user_id { |n| "#{n}" }
    work_date { Date.today }
    work_start { DateTime.now }
    work_end { DateTime.now }
    status { "work" }
  end
end
