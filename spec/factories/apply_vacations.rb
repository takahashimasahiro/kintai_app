FactoryBot.define do
  factory :apply_vacation do
    applicant_id { 1 }
    get_start_date { "2018-11-06" }
    get_days { "" }
    authorizer_id { 1 }
    status { "MyString" }
  end
end
