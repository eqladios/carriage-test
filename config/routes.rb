Rails.application.routes.draw do
  
  resources :cards do
    resources :comments
  end

  resources :comments, except: [ :index ] do
    resources :comments
  end

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
