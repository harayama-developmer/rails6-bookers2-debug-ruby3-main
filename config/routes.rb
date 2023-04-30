Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "searches"=>"searches#search"
  get "categories"=>"searches#categories"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :conversations, only: [:show, :create] do
    resources :messages, only: [:create]
  end

  resources :groups do
    resource :group_user, only: [:create, :destroy]
    resources :group_events, only: [:show, :new, :create]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :following
      get :followers
      get :search
    end

    resource :relationship, only: [:create, :destroy]
  end
end