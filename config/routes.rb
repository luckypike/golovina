Rails.application.routes.draw do
  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  resources :themes
  resources :colors
  resources :kits
  resources :categories, path: :catalog do
    resources :products, only: :show, path: '' do
      resources :variants, only: [:index, :create, :destroy]
      resource :variants, only: [:update]
    end
  end
  resources :products, except: [:show, :new, :edit]

  get 'demo', to: 'products#demo', as: :demo

  # get 'colors', to: 'themes#colors', as: :colors
end
