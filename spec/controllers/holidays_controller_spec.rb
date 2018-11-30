require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  let(:user){ FactoryBot.create :user do |u|
      u.apply_vacations.create{ FactoryBot.create(:apply_vacation) }
    end
  }
  before do
    user
    session[:id] = '1'
  end

  describe 'GET #show' do
    it 'returns http success' do
      # expect(user).to receive(:apply_vacations).and_return(user.apply_vacations)
      # expect(user.apply_vacations).to receive_message_chain( :all, :order).with(no_args).with(:get_start_date).and_return([])
      # expect(user.apply_vacations).to receive_message_chain( :where, :count).with(status: :applying).with(no_args).and_return(0)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe ' #edit' do
    it 'returns http success' do
      get :edit, params: { id: :id }
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe ' #update' do
    let(:params) do {
        id: '1',
        user_id: '1',
        get_date: Date.today.strftime('%Y-%m-%d'),
        approve: nil,
        dismiss: nil,
        button: nil
      }
    end
    it '申請許可' do
      # FactoryBot.create :apply_vacation, applicant_id: :id
      params[:approve] = ''
      # params[:dismiss] = nil
      params[:button] = 'admin_applied'
      vacation =  user.apply_vacations
      expect(ApplyVacation).to receive(:find_by).with(applicant_id: params[:user_id], get_start_date: params[:get_date]).and_return(vacation)
      expect(vacation).to receive(:status)
      # expect(ApplyVacation).to receive(:reduce_holiday_count)
      expect(user).to receive(:save!).and_return(true)
      patch :update, params: params
      expect(response).to have_http_status '302'
    end

    xit '申請却下' do
      # FactoryBot.create(:apply_vacation)
      # params[:approve] = nil
      params[:dismiss] = ''
      params[:button] = 'apply_rejection'
      # expect(ApplyVacation).to receive(:status)
      expect(apply_vacation).to receive(:save).and_return(true)
      patch :update, params: params
      expect(response).to have_http_status '302'
    end
  end
end
