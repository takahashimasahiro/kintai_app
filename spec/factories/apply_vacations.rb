FactoryBot.define do
  factory :apply_vacation do
    applicant_id { |n| "#{n}" }
    get_start_date { Date.Today }
    get_days { '1' }
    authorizer_id { nil }
    status { "applying" }
  end
end
