Rails.application.routes.draw do
 
  root to: "homes#top"
  devise_for :users
  
  resources :users, only: [:show, :index, :edit, :update]
  resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  
  get 'home/about', to: 'homes#about', as: 'about'
  
end
