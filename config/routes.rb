Rails.application.routes.draw do
  root 'pages#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :deliveries, path: :delivery, only: [:index], controller: 'markets' do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  resources :favorites, path: :favoritos, only: [:index, :create, :destroy]

  resources :markets, path: :comercio, only: [:index], controller: 'markets' do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  resources :properties, path: :imoveis, only: [:index] do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  scope :gestao, module: :admin, as: :admin do
    get '', to: 'dashboards#index'

    resources :customer_commons, path: :clientes do
      resources :customers, path: :filiais do
        collection { get 'add_contact_phone' }
      end
    end

    resources :dashboards, only: [:index]

    resources :markets, path: :comercios do
      resources :categories, path: :tipos, only: [:index, :new, :create, :destroy],
        controller: 'markets/categories' do

          resources :specialities, path: :especialidades,
            only: [:index, :new, :create, :destroy],
            controller: 'markets/specialities'

        end

      resources :payment_methods, path: :formas_pagamento,
        only: [:index, :new, :create, :destroy],
        controller: 'markets/payment_methods'

      resources :products, path: :produtos, controller: 'markets/products'

      resources :working_hours, path: :expediente,
        only: [:index, :new, :edit, :create, :update, :destroy],
        controller: 'markets/working_hours'
    end

    resources :properties, path: :imoveis do
      resources :property_images, path: :imagens
    end

    resources :users, path: :usuarios
  end
end
