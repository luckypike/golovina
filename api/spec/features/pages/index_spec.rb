require 'rails_helper'

feature 'Index page', :js do
  it 'shows title' do
    visit contacts_path

    expect(page).to have_text(I18n.t('header.nav.contacts'))
  end
end
