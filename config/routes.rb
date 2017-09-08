Rails.application.routes.draw do
  root 'static#index'

  scope format: false do
    devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

    scope 'about' do
      get '', to: 'about#index', as: :about_index
    end
  end



  get :contacts, to: 'static#contacts'

  resources :themes, path: :styles, except: [:destroy]

  resources :kits

  resources :images, only: [:create, :show, :destroy]
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

  resources :products, path: :catalog, except: [:destroy] do
    member do
      post :publish
      post :archive
      get :variants
    end

    collection do
      get :control
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
  get 'cart', to: 'cart#show'
end
