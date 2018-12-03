FactoryBot.define do
  factory :user ,class: User do
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

  factory :apply_vacations , class: ApplyVacation do
    get_start_date { Date.today }
    get_days { '1' }
    authorizer_id { nil }
    status { 'applying' }
  end
end
