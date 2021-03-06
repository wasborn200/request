Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/like',    to: 'favorites#create'
  delete '/unlike',  to: 'favorites#destroy'
  resources :users do
    member do
      get :following, :followers, :message
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts do
    resources :comments,          only: [:create, :destroy]
    resources :likes,             only: [:create, :destroy]
    collection do
      get :collabposts
    end
  end
  resources :relationships,       only: [:create, :destroy]
  resources :messages,            only: [:index]
  resources :favlists do
    member do
      get :likes
    end
  end
  resources :favorites,           only: [:create, :destroy]
  mount ActionCable.server => '/cable'
end
