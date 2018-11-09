FactoryBot.define do
  factory :user do
    email { |n| "TEST#{n}@example.com"}
    name { |n| "TEST_NAME#{n}" }
    password { "password" }
    role { "owner" }
    paid_holiday_count { "10" }
  end
end
