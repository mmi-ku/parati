Rails.application.routes.draw do

  root to: "homes#top"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show, :index, :edit, :update]
  resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update]
  end

  get 'home/about', to: 'homes#about', as: 'about'

  get "search" => "searches#search"

  patch 'withdraw/:id' => 'users#withdraw', as: 'withdraw_user'
  put 'withdraw/:id' => 'users#withdraw'

end
