Rails.application.routes.draw do
  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :themes
  resources :kits
  resources :categories, path: :catalog do
    resources :products, only: :show, path: ''
  end
  resources :products, except: [:index, :show]

  get 'colors', to: 'themes#colors', as: :colors
end
