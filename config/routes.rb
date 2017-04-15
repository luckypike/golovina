Rails.application.routes.draw do
  resources :themes
  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :kits
  resources :categories
  resources :products
end
