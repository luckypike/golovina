Rails.application.routes.draw do
  root 'static#index'

  get :wishlist, to: 'wishlists#show'

  resources :variants, except: [:show] do
    member do
      post :wishlist
      post :cart
    end
  end

  resources :categories, except: [:show]

  scope path: :catalog, as: :catalog do
    get '', to: 'variants#all'
    get 'control', to: 'products#control', as: :control
    get :latest, controller: :variants
    get :sale, controller: :variants
    get :soon, controller: :variants
    get ':slug', to: 'categories#show', as: :category
    get ':slug/:id', to: 'variants#show', as: :variant
  end

  resources :themes, path: :styles, except: [:destroy] do
    collection do
      get :latest
    end
  end

  namespace :cart do
    get '', action: :index
    delete ':id', action: :destroy, as: :destroy
  end

  devise_for :users,
    path: '',
    only: :sessions,
    controllers: {
      sessions: :sessions
    },
    path_names: {
      sign_in: 'login', sign_out: 'logout'
    }

  devise_scope :user do
    post :recovery, controller: :sessions, as: :recovery_user_session
    post :phone, controller: :sessions, as: :phone_user_session
    post :code, controller: :sessions, as: :code_user_session
    get :auth, controller: :sessions, as: :auth_user_session
  end
  # devise_for :users

  # namespace 'login', module: nil do
  #   get :email, to: 'sessions#email'
  #   get '', to: 'sessions#login'
  #   post 'code', to: 'sessions#code'
  #   post '', to: 'sessions#auth'
  # end


  resources :sizes
  resources :sizes_groups

  resources :collections

  scope format: false do
    namespace 'about', module: nil do
      get '', to: 'about#collection'
      # get 'open', to: 'about#open'
      namespace 'golovina', module: nil do
        get '', to:  'about#brand'
        get 'lookbook', to: 'about#lookbook'
        get 'xmas', to: 'about#xmas'
      end
    end

    namespace 'service', module: nil do
      get '', to: 'service#index'
      get 'delivery', to: 'service#delivery'
      get 'return', to: 'service#return'
    end

    resources :users, only: [] do
      member do
        get :orders, format: :json
      end
    end
  end

  get :contacts, to: 'static#contacts'

  get 'robots.:format', to: 'static#robots'

  resources :kits, only: :show

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


  # get 'posts', to: redirect('/posts/1')

  resources :posts

  resources :orders, only: [:index, :create] do
    collection do
      post :paid
    end

    member do
      post :archive
      get :pay
    end
  end

  resources :slides, except: [:show]
end
