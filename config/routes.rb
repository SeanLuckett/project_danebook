Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :accounts
  resources :users, only: [:show, :edit, :update]
  resources :friendings, only: [:create, :destroy]

  resources :posts, only: [:create, :destroy] do
    resources :likes, defaults: { likable: 'Post' }, only: :create
    delete '/like', to: 'likes#destroy', defaults: { likable: 'Post' }

    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy] do
    resources :likes, defaults: { likable: 'Comment' }, only: :create
    delete '/like', to: 'likes#destroy', defaults: { likable: 'Comment' }
  end

  resources :photos, only: [:new, :create, :show]


  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy', method: :destroy

  get '/timeline/:user_id', to: 'timelines#show', as: :timeline
  get '/friends/:user_id', to: 'friends#index', as: :friends
  get '/photo-list/:user_id', to: 'photos#index', as: :photo_list

  get '/signup', to: 'accounts#new'

  root to: 'sessions#new'

  unless Rails.env == 'development'
    get '*path' => redirect('/logout')
  end
end
