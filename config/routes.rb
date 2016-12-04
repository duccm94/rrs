Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :notifications
  resources :restaurants, controller: "books", only: [:index, :show] do
    resources :reviews do
      resources :comments, except: [:index, :show]
    end
    resources :marks, only: [:create, :edit, :update, :destroy]
  end

  resources :requests, except: [:show, :edit, :update]

  resources :users do
    get "/:relationship", on: :member,
      :to => "relationships#index", :as => :relationships
    resources :like_activities, only: [:create, :destroy]
    resources :like_books, only: [:create, :destroy]
    resources :like_reviews, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root "sessions#new"
    resources :categories
    resources :restaurants, controller: "books" do
      resources :reviews, only: [:destroy] do
        resources :comments, only: [:destroy]
      end
    end
    resources :requests
    resources :users, only: [:index, :destroy]
  end
end
