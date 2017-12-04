Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :accounts

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:create, :destroy] do
    resources :likes, defaults: { likable: 'Post' }, only: :create
    delete '/like', to: 'likes#destroy'
  end

  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy', method: :destroy

  get '/timeline/:user_id', to: 'timelines#show', as: :timeline

  get '/signup', to: 'accounts#new'

  root to: 'sessions#new'

  unless Rails.env == 'development'
    get '*path' => redirect('/logout')
  end
end
