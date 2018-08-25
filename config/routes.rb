Rails.application.routes.draw do
  
  resources :cards, except: [:index, :show, :create, :update, :destroy] do
    resources :comments
  end

  resources :comments, except: [:index] do
    resources :comments
  end

  resources :lists do
    resources :cards
  end

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
  post '/lists/:id/users/:user_id', to: 'lists#assign'
  delete '/lists/:id/users/:user_id', to: 'lists#unassign'

  root to: "static_pages#index"
end
