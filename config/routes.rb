Rails.application.routes.draw do
  root 'pages#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # properties
  resources :properties, path: 'imoveis', only: [:index]
end
