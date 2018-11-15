# frozen_string_literal: true

FactoryBot.define do
  factory :apply_vacation do
    applicant_id(&:to_s)
    get_start_date { Date.Today }
    get_days { '1' }
    authorizer_id { nil }
    status { 'applying' }
  end
end
