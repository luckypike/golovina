Rails.application.routes.draw do
  root 'static#index'

  scope format: false do
    devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

    namespace 'about', module: nil do
      get '', to: 'about#index'
    end

    namespace 'customers', module: nil do
      get '', to: 'customers#index'
      get 'delivery', to: 'customers#delivery'
      get 'payment', to: 'customers#payment'
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

  resources :variants, only: [:create, :update, :destroy] do
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
  get 'cart', to: 'cart#show'

  resources :orders, only: [] do
    member do
      post :checkout
    end
  end
end
