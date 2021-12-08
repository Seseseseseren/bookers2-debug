Rails.application.routes.draw do
  get 'chats/show'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search' => 'searches#search'

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :groups, except: [:destroy]

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followed, on: :member
    get :follower, on: :member
  end
  
   resources :groups do
    get "join" => "groups#join"
  end

  resources :books do
  resources :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  end

end