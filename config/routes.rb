Rails.application.routes.draw do
  devise_for :users

  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :themes, only: [:index, :show]
  resources :colors, only: [:index, :show]

  resources :kits
  resources :categories, only: [:index, :show], path: :catalog do
    resources :products, only: [:show], path: ''
  end

  resources :products, except: [:index, :show] do
    resources :variants, only: [:index, :create]
    post :wishlist, on: :member
  end

  get 'wishlist', to: 'wishlists#show'

  get 'demo', to: 'products#demo', as: :demo

  # get 'colors', to: 'themes#colors', as: :colors
end
