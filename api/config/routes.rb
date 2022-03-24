# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  namespace :api, defaults: { format: :json }, format: false do # rubocop:disable Metrics/BlockLength
    namespace :pages do
      get :index
    end

    resource :session, only: %i[show destroy] do
      post :apple
      post :code
    end
    resources :variants, only: %i[new edit create update]
    resources :images, only: %i[create] do
      collection do
        post :touch
      end
    end

    resources :subscriptions, only: %i[create]
    resource :cart, only: %i[show] do
      member do
        post :checkout
        post :delivery
        post :verify
        post :promo_code, action: :apply_promo_code
        delete :promo_code, action: :delete_promo_code
        delete "order_items/:id", action: :delete_order_item
      end
    end

    namespace :account do
      resources :refunds, only: %i[create new]
    end

    namespace :dashboard do
      resources :refunds, only: %i[index] do
        member do
          post :archive
        end
      end
    end

    get :status, to: "status#index"
  end

  get :robots, to: "pages#robots"
  get :wishlist, to: "wishlists#show"
  get :search, to: "search#index"

  resources :variants, except: [:show] do
    collection do
      get :list
    end

    member do
      post :wishlist
      post :cart
    end

    resources :availabilities, only: %i[index create destroy]
  end

  resources :acts, only: :create

  resources :categories, except: [:show]

  resources :themes, except: [:show]

  scope path: :catalog, as: :catalog do
    get "", to: "variants#all"
    get ":id", to: "themes#show", constraints: lambda { |request|
                                                 Theme.find_by(slug: request.params[:id]).present?
                                               }, as: :theme
    get ":slug", to: "categories#show", constraints: lambda { |request|
                                                       Category.find_by(slug: request.params[:slug]).present?
                                                     }, as: :category
    # get ':slug', to: 'categories#show', as: :category
    get ":slug/:id", to: "variants#show", as: :variant
  end

  devise_for :users,
             path: "",
             only: :sessions,
             controllers: {
               sessions: :sessions
             },
             path_names: {
               sign_in: "login", sign_out: "logout"
             }

  devise_scope :user do
    post "auth/apple(/:from)", to: "users/omniauth_callbacks#apple"
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

  namespace :dashboard, module: nil do
    get "", to: "dashboard#index"

    namespace :catalog, module: nil do
      get "", to: "dashboard#catalog"
      post "", to: "dashboard#catalog_update"
      get :items, to: "dashboard#items"
      post :items, to: "dashboard#items_update"
      # get :variants, to: 'dashboard#variants'
      # post :variants, to: 'dashboard#variants_update'
    end

    get :archived, to: "dashboard#archived"
    get :cart, to: "dashboard#cart"
    get :wishlists, to: "dashboard#wishlists"
    get :users, to: "dashboard#users"
    get "/users/:id", to: "dashboard#user", as: "user"
  end

  resources :sizes
  resources :sizes_groups

  resources :collections

  resources :kits do
    collection do
      get :control
    end
  end

  resources :images, only: %i[create show destroy] do
    collection do
      post :weight
    end
  end

  resources :colors, except: [:show]

  resources :statistics

  resources :orders, only: [] do
    collection do
      post :paid
    end

    member do
      post :delivery
      patch :checkout
      post :archive
      post :unarchive
      get :pay
    end
  end

  resources :order_items, only: %i[destroy]

  resources :slides, except: [:show]
end
