Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy', method: :destroy

  resources :accounts
  resources :users, only: [:show, :edit, :update]

  get '/signup', to: 'accounts#new'

  root to: 'sessions#new'

  get '*path' => redirect('/logout')
end
