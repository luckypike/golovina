require 'rails_helper'

feature 'Sections page', :js do
  it 'shows title on New' do
    visit catalog_latest_path

    expect(page).to have_text(I18n.t('variants.latest.title'))
  end

  it 'shows title on Morning' do
    visit catalog_morning_path

    expect(page).to have_text(I18n.t('variants.morning.title'))
  end

  it 'shows title on Premium' do
    visit catalog_premium_path

    expect(page).to have_text(I18n.t('variants.premium.title'))
  end

  it 'shows title on Sale' do
    visit catalog_sale_path

    expect(page).to have_text(I18n.t('variants.sale.title'))
  end

  it 'shows title on Stayhome' do
    visit catalog_basic_path

    expect(page).to have_text(I18n.t('variants.stayhome.title'))
  end

  it 'shows title on Last' do
    visit catalog_last_path

    expect(page).to have_text(I18n.t('variants.last.title'))
  end

  it 'shows title on All' do
    visit catalog_path

    expect(page).to have_text(I18n.t('variants.all.title'))
  end
end
