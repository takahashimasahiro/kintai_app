FactoryBot.define do
  factory :apply_vacation do
    id { |n| n }
    get_start_date { Date.today }
    get_days { '1' }
    authorizer_id { nil }
    status { 'applying' }
  end
end
