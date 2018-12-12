require 'rails_helper'

RSpec.describe User, type: :model do
  let(:owner_user) { User.find_by(role: :owner) }
  let(:employee_user) { User.find_by(role: :employee) }
  before do
    FactoryBot.create :user
    FactoryBot.create :user, :employee
  end

  describe "it's owner" do
    it 'Get Data YourSelf' do
      expect(User.select_user(1, owner_user)).to eq owner_user
    end

    it 'Get Select User Data' do
      expect(User.select_user(2, owner_user)).to eq employee_user
    end
  end

  describe 'not owner' do
    it 'Get Data YourSelf' do
      expect(User.select_user(2, employee_user)).to eq employee_user
    end

    it "can't get it except yourself " do
      expect(User.select_user(1, employee_user)).to eq employee_user
    end
  end

  describe 'applied_for_month' do
    let(:apply_vacation){ ApplyVacation.find_by(applicant_id: owner_user.id)}
    before do
      FactoryBot.create :apply_vacation, applicant_id: owner_user.id
    end

    it 'get data' do
      apply_vacation.status = :admin_applied
      apply_vacation.save
      expect(owner_user.applied_for_month(Date.today.change(day: 1)).count).to eq 1
    end

    it 'no data' do
      expect(owner_user.applied_for_month(Date.today.change(day: 1)).count).to eq 0
    end
  end

  # TODO かく
  describe 'vacation_count_for_month' do
    it 'get count' do
    end
  end
  
end
