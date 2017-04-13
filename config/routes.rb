Rails.application.routes.draw do
  get 'about/index'

  root 'static#index'

  scope 'about' do
    get '', to: 'about#index'
  end

  resources :categories
  resources :products
end
