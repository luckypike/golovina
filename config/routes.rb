Rails.application.routes.draw do
  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :looks
  resources :kits
  resources :categories
  resources :products
end
