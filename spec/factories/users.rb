FactoryBot.define do
  factory :user do
    id { '1' }
    email { 'TEST@example.com' }
    name { 'TEST_NAME' }
    password { 'password' }
    role { 'owner' }
    paid_holiday_count { '10' }
    
    trait :employee do
      id { '2' }
      email { 'TESTemp@example.com' }
      name { 'EMP_NAME' }
      password { 'password' }
      role { 'employee' }
      paid_holiday_count { '10' }
    end
  end
end
