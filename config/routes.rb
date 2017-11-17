Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new'
  resources :users

  root to: 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
