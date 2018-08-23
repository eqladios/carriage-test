Rails.application.routes.draw do
  resources :cards
  resources :comments
  resources :lists
  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  get '/users/index', to: 'users#index'
  root to: "static_pages#index"
end
