Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  root 'pages#index'

  get :robots, to: 'pages#robots'
  get :contacts, to: 'pages#contacts'

  get :wishlist, to: 'wishlists#show'

  get :search, to: 'search#index'

  resources :variants, except: [:show] do
    collection do
      get :list
    end

    member do
      post :wishlist
      post :cart
    end
  end

  resources :categories, except: [:show]

  scope path: :catalog, as: :catalog do
    get '', to: 'variants#all'
    get 'control', to: 'products#control', as: :control
    get :last, controller: :variants
    get :latest, controller: :variants
    get :sale, controller: :variants
    get :soon, controller: :variants
    get :premium, controller: :variants
    get :stayhome, controller: :variants
    get :morning, controller: :variants
    get ':slug', to: 'categories#show', as: :category
    get ':slug/:id', to: 'variants#show', as: :variant
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
    post 'auth/apple(/:from)', to: 'users/omniauth_callbacks#apple'
    post :recovery, controller: :sessions, as: :recovery_user_session
    get :auth, controller: :sessions, as: :auth_user_session
  end

  resource :account, only: :show do
    scope module: :accounts do
      resource :password, only: %i[show update]

      resource :user, only: %i[show update] do
        collection do
          get :password
        end
      end
    end
  end

  resources :sizes
  resources :sizes_groups

  resources :collections

  scope format: false do
    namespace 'service', module: nil do
      get '', to: 'service#index'
      get 'delivery', to: 'service#delivery'
      get 'return', to: 'service#return'
      get 'refund', to: 'refunds#refund', format: :json
    end

    resources :users, only: [] do
      member do
        get :orders, format: :json
        get :refunds, format: :json
      end
    end
  end

  resources :kits do
    collection do
      get :control
    end
  end

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

  # get 'account/orders', to: 'users#account'

  resources :posts

  resources :statistics

  resources :promos do
    collection do
      get :last
    end
  end

  resources :refunds do
    member do
      post :done
    end
  end

  resources :orders, only: %i[index] do
    collection do
      post :paid
    end

    member do
      patch :checkout
      post :archive
      get :pay
    end
  end

  resources :order_items, only: %i[destroy]

  get :cart, to: 'orders#cart'

  resources :slides, except: [:show]
end
