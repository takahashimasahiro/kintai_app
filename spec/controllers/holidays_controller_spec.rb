require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  describe 'GET #show' do
    let(:current_user) { User.find(1) }
    subject { get :show, params }
    let(:params) do
      {
        id: 1
      }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

end
