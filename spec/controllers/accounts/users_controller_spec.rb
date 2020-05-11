require 'rails_helper'

describe Accounts::UsersController do
  describe 'GET #show' do
    let(:guest_user) { create(:guest_user) }
    let(:common_user) { create(:common_user) }

    context 'by anonymous user' do
      before { get :show }

      it { should redirect_to(new_user_session_path) }
    end

    context 'by guest user' do
      before do
        sign_in guest_user
        get :show
      end

      it { should redirect_to(new_user_session_path) }
    end

    context 'by common user' do
      before do
        sign_in common_user
        get :show
      end

      it { should render_template('show') }
    end
  end
end
