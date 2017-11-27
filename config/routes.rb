Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy', method: :destroy

  resources :users do
    resources :profiles, only: [:show, :edit, :update]
  end

  get '/signup', to: 'users#new'

  root to: 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
