Rails.application.routes.draw do
  devise_for :users

  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :themes
  resources :colors
  resources :kits
  resources :categories, path: :catalog do
    resources :products, only: [:show, :new, :create], path: '' do
      resources :variants, only: [:index, :create]
    end
  end
  resources :products, only: [:edit, :update, :destroy] do
    member do
      post :wishlist
    end
  end

  get 'wishlist', to: 'wishlists#show'

  get 'demo', to: 'products#demo', as: :demo

  # get 'colors', to: 'themes#colors', as: :colors
end
