FactoryBot.define do
  factory :user do
    user_id { "" }
    email { "" }
    name { "" }
    password { "" }
    role { "MyString" }
    paid_holiday_count { "" }
  end
end
