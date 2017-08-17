Rails.application.routes.draw do
  devise_for :users

  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  get :contacts, to: 'static#contacts'

  resources :kinds, except: [:show]

  # get '/:theme', to: 'themes#show', constraints: lambda { |req| Theme.find_by_slug(req.path[1..-1]) }, as: :theme
  resources :themes, path: :styles

  resources :kits
  # resources :categories, only: [], path: :catalog do
    # resources :products, only: [:show], path: ''
  # end

  resources :products, path: :catalog do
    resources :variants, only: [:index, :create]
    post :wishlist, on: :member

    collection do
      get :all
      get :latest
      get :sale
    end
  end

  resources :images

  # get :new, to 'products#new'
  # get :new, to 'products#new'

  get 'wishlist', to: 'wishlists#show'
end
