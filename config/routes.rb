Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "searches"=>"searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :conversations, only: [:show, :create] do
    resources :messages, only: [:create]
  end

  resources :groups

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :following
      get :followers
      get :search
    end

    resource :relationship, only: [:create, :destroy]
  end
end