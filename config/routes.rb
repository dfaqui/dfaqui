Rails.application.routes.draw do
  root 'pages#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :markets, path: :comercio, only: [:index]
  resources :markets, path: :delivery, only: [:index]

  resources :properties, path: :imoveis, only: [:index] do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end
end
