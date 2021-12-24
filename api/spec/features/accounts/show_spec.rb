require 'rails_helper'

feature 'User visits account page', :js do
  let(:common_user) { create(:common_user) }

  before do
    sign_in common_user
  end

  it 'shows title' do
    visit account_path

    expect(page).to have_text(I18n.t('accounts.show.title'))
  end
end
