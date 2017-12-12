Rails.application.routes.draw do
  root 'static#index'

  scope format: false do
    devise_for :users, path: '', path_names: { sign_out: 'logout'}

    namespace 'login', module: nil do
      get '', to: 'sessions#login'
      post 'code', to: 'sessions#code'
      post '', to: 'sessions#auth'
    end


    namespace 'about', module: nil do
      get '', to: 'about#index'
      namespace 'golovina', module: nil do
        get '', to:  'about#collection'
        get 'lookbook', to: 'about#lookbook'
        get 'brand', to: 'about#brand'
      end
    end

    namespace 'customers', module: nil do
      get '', to: 'customers#index'
      get 'info', to: 'customers#info'
      get 'return', to: 'customers#return'
    end
  end

  get :contacts, to: 'static#contacts'

  get 'robots.:format', to: 'static#robots'

  resources :themes, path: :styles, except: [:destroy]

  resources :kits

  resources :images, only: [:create, :show, :destroy] do
    collection do
      post :weight
    end
  end

  resources :variants, only: [:index, :create, :update, :destroy] do

    member do
      get :images
    end

    collection do
      post :wishlist
      post :cart
    end

  end

  resources :categories, except: [:show]

  resources :colors, except: [:show]

  resources :products, path: :catalog do
    member do
      post :publish
      post :archive
      get :variants
      get :info
      get 'similar/:simid', to: 'products#similar', as: 'similar'
    end

    collection do
      get :control
      get :all
      get :latest
      get :kits
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
  # get 'cart', to: 'cart#show'
  namespace 'cart', module: nil do
    get '', to: 'cart#show'
    delete ':id/destroy', to: 'cart#destroy', as: :destroy
  end

  resources :orders, only: [:index] do
    member do
      post :checkout
    end
  end

  resources :slides, except: [:show]
end
