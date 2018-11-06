require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  describe 'GET #show' do
    let(:params) { { id: 1 } }
    subject { get :show, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

end
