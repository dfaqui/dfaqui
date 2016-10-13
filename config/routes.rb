Rails.application.routes.draw do
  root 'pages#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :markets, path: :comercio, only: [:index]

  resources :markets, path: :delivery, only: [:index] do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  resources :properties, path: :imoveis, only: [:index] do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  scope :gestao, module: :admin, as: :admin do
    resources :customer_commons, path: :clientes do
      resources :customers, path: :filiais do
        collection { get 'add_contact_phone' }
      end
    end

    resources :properties, path: :imoveis do
      resources :property_images, path: :imagens
    end
  end
end
