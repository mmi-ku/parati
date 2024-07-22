Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
      sessions: 'admin/sessions'
    }
    
    namespace :admin do
      resources :genres, only: [:create, :index, :edit, :update]
      get 'dashboards', to: 'dashboards#index'
      resources :users, only: [:destroy]
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
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
    get 'home/about', to: 'homes#about', as: 'about'
    
    resources :users, only: [:show, :index, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
      	get "followers" => "relationships#followers", as: "followers"
    end
  
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
     resources :post_comments, only: [:create]
    end
    
    get "search" => "searches#search"
    patch 'withdraw/:id' => 'users#withdraw', as: 'withdraw_user'
    put 'withdraw/:id' => 'users#withdraw'

  end
end 
