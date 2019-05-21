require 'rails_helper'

feature 'Signing in' do
  given(:user) { create(:user) }

  scenario 'with correct credentials', :js do
    visit new_user_session_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Войти'
    wait_for_ajax

    expect(current_path).to eq(root_path)
  end

  scenario 'with wrong credentials', :js do
    visit new_user_session_path

    fill_in :email, with: user.email
    fill_in :password, with: ''
    click_button 'Войти'

    expect(page).to have_content 'Неверная почта или пароль'
  end

  scenario 'with phone with corrent code', :js do
    visit new_user_session_path

    fill_in :phone, with: user.phone
    click_button 'Получить код'
    wait_for_ajax

    fill_in :code, with: user.reload.code
    click_button 'Подтвердить телефон'
    wait_for_ajax

    expect(current_path).to eq(root_path)
  end

  scenario 'with phone with wrong code', :js do
    visit new_user_session_path

    fill_in :phone, with: user.phone
    click_button 'Получить код'
    wait_for_ajax

    fill_in :code, with: rand.to_s[2..5]
    click_button 'Подтвердить телефон'

    expect(page).to have_content 'Неверный код из SMS'
  end

  # scenario 'Recovery', :js do
  #   visit new_user_session_path
  #   find('#recovery').click
  #   # click_on 'Забыли пароль?', wait: 5
  #   # fill_in :phone, with: user.phone
  #
  #   fill_in :email, with: user.email
  #   click_button 'Восстановить пароль', wait: 6
  #
  #   # expect(page).to have_content 'Неверная почта или пароль'
  # end

end
