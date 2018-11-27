# frozen_string_literal: true

FactoryBot.define do
  factory :apply_vacation do
    id 1
    applicant_id(&:to_s)
    get_start_date { Date.today }
    get_days { '1' }
    authorizer_id { nil }
    status { 'applying' }
  end
end
