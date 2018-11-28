FactoryBot.define do
  factory :user do
    id 1
    email { 'TEST@example.com' }
    name { 'TEST_NAME' }
    password { 'password' }
    role { 'owner' }
    paid_holiday_count { '10' }
  end
end
