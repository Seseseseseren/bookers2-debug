Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search' => 'searches#search'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followed, on: :member
    get :follower, on: :member
  end

  resources :books do
  resources :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  end

end