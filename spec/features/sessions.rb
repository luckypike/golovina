require 'rails_helper'

feature 'Signing in' do
  # background do
  #   User.make(email: 'user@example.com', password: 'caplin')
  # end
  given(:user) { create(:user) }

  # scenario 'Signing in with correct credentials', :js do
  #   visit new_user_session_path
  #   fill_in :email, with: user.email
  #   fill_in :password, with: user.password
  #
  #   click_button 'Войти'
  #
  #   expect(current_path).to eq(root_path)
  # end
  #
  # scenario 'Signing in with wrong credentials', :js do
  #   visit new_user_session_path
  #   fill_in :email, with: user.email
  #   fill_in :password, with: ''
  #
  #   click_button 'Войти'
  #
  #   expect(page).to have_content 'Неверная почта или пароль'
  # end

  scenario 'Signing in with phone', :js do
    visit new_user_session_path
    fill_in :phone, with: user.phone

    click_button 'Получить код', wait: 25

    fill_in :code, with: user.code
    # click_button 'Подтвердить телефон'

    # expect(page).to have_content 'Неверная почта или пароль'
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
