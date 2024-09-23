Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
      sessions: "admin/sessions"
    }

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]

    get "dashboards", to: "dashboards#index"
    resources :users, only: [] do
      member do
        patch :withdraw
      end
      resources :posts, only: [:index], controller: "users/posts"
    end
  end

  scope module: :public do
    root to: "homes#top"

    # devise_for :admin, skip: [:registrations, :password], controllers: {
    #   sessions: 'admin/sessions'
    # }

    # namespace :admin do
    #   resources :genres, only: [:create, :index, :edit, :update]
    #   get 'dashboards', to: 'dashboards#index'
    #   resources :users, only: [:destroy]
    # end

    devise_for :users, controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }
    get "home/about", to: "homes#about", as: "about"

    resources :users, only: [:show, :index, :edit, :update] do
      patch "withdraw", on: :member, as: "withdraw_user"
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end

    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :edit, :update, :destroy]
    end

    get "search" => "searches#search"
    patch "withdraw/:id" => "users#withdraw", as: "withdraw_user"
    put "withdraw/:id" => "users#withdraw"
  end

  resources :notifications, only: [:update]
end
