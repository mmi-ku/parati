Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
      sessions: 'admin/sessions'
    }

    namespace :admin do
      resources :genres, only: [:create, :index, :edit, :update, :destroy]
      get 'dashboards', to: 'dashboards#index'
      resources :users, only: [] do
        member do
          patch :withdraw
        end
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
      registrations: 'public/registrations',
      sessions: 'public/sessions'
    }
    get 'home/about', to: 'homes#about', as: 'about'

    resources :users, only: [:show, :index, :edit, :update] do
      patch 'withdraw', on: :member, as: 'withdraw_user'
      resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
      	get "followers" => "relationships#followers", as: "followers"

    end

    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
     resources :post_comments, only: [:create, :edit, :update, :destroy]
    end

    get "search" => "searches#search"
    patch 'withdraw/:id' => 'users#withdraw', as: 'withdraw_user'
    put 'withdraw/:id' => 'users#withdraw'

  end
end
