Rails.application.routes.draw do
  get 'images/create'

  devise_for :users

  root 'static#index'

  scope 'about' do
    get '', to: 'about#index', as: :about_index
  end

  get :contacts, to: 'static#contacts'

  resources :themes, path: :styles, except: [:index, :destroy]

  resources :kits

  resources :images, only: [:create, :show, :destroy]
  resources :variants, only: [:create, :update] do
    member do
      get :images
    end
  end

  resources :categories

  resources :products, path: :catalog, except: [:destroy] do
    member do
      post :publish
      get :variants
    end

    collection do
      get :all
      get :latest
      get :sale
      get ':slug', to: 'products#category', as: :category, constraints: lambda { |request| Category.find_by_slug(request.params[:slug]).present? }
    end

  end

  # resources :products, path: :catalog do
  #   resources :variants, only: [:create]
  #   post :wishlist, on: :member

  #   collection do
  #     get :all
  #     get :latest
  #     get :sale
  #   end
  # end

  get 'wishlist', to: 'wishlists#show'
end
