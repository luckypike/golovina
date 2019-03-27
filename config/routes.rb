Rails.application.routes.draw do
  root 'static#index'

  resources :variants, except: [:show] do
    member do
      post :wishlist
      post :cart
    end
  end

  resources :categories, except: [:show]

  scope path: :catalog, as: :catalog do
    get '', to: 'variants#all'
    get :latest, controller: :variants
    get :sale, controller: :variants
    get ':slug', to: 'categories#show', as: :category
    get ':slug/:id', to: 'variants#show', as: :variant
  end

  resources :sizes
  resources :sizes_groups



  scope format: false do
    devise_for :users, path: '', path_names: { sign_out: 'logout'}

    namespace 'login', module: nil do
      get '', to: 'sessions#login'
      post 'code', to: 'sessions#code'
      post '', to: 'sessions#auth'
    end


    namespace 'about', module: nil do
      get '', to: 'about#collection'
      # get 'open', to: 'about#open'
      namespace 'golovina', module: nil do
        get '', to:  'about#brand'
        get 'lookbook', to: 'about#lookbook'
        get 'xmas', to: 'about#xmas'
      end
    end

    namespace 'customers', module: nil do
      get '', to: 'customers#index'
      get 'info', to: 'customers#info'
      get 'return', to: 'customers#return'
    end

    resources :collections

    resources :users, only: [] do
      member do
        get :orders, format: :json
      end
    end
  end

  get :contacts, to: 'static#contacts'

  get 'robots.:format', to: 'static#robots'

  resources :themes, path: :styles, except: [:destroy] do
    collection do
      get :latest
    end
  end

  resources :kits

  resources :images, only: [:create, :show, :destroy] do
    collection do
      post :weight
    end
  end


  resources :colors, except: [:show]

  resources :discounts

  # resources :products, path: :catalog do
  #   member do
  #     # post :publish
  #     # post :archive
  #     get :info
  #     get 'similar/:simid', to: 'products#similar', as: 'similar'
  #   end
  #
  #   collection do
  #     # get 'control', to: 'products#control', as: :control
  #     # get 'control/archive', to: 'products#control'
  #     # get :all
  #     get :latest
  #     # get :golovina
  #     # get :kits
  #     get :sale
  #     get ':slug', to: 'products#category', as: :category, constraints: lambda { |request| Category.find_by_slug(request.params[:slug]).present? }
  #   end
  # end

  # resources :products, path: :catalog do
  #   resources :variants, only: [:create]
  #   post :wishlist, on: :member

  #   collection do
  #     get :all
  #     get :latest
  #     get :sale
  #   end
  # end

  get 'account/orders', to: 'users#account'

  get 'wishlist', to: 'wishlists#show'
  # get 'cart', to: 'cart#show'
  namespace 'cart', module: nil do
    get '', to: 'cart#show'
    get '/discount', to: 'cart#discount'
    delete ':id/destroy', to: 'cart#destroy', as: :destroy
  end

  get 'posts', to: redirect('/posts/1')

  resources :posts

  resources :orders, only: [:index] do
    collection do
      post :paid
    end

    member do
      post :archive
      post :checkout
      get :pay
    end
  end

  resources :slides, except: [:show]
end
