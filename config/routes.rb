Rails.application.routes.draw do
  root 'pages#home'

  post 'pages/dynamic_content'

  # solucao paliativa até os links do tour serem atualizados
  get '/imoveis/:region/site/lista', to: redirect { |params, request|
    type                = [:residential, :commercial]
    situation           = [:release, :sale, :rent]

    request_query       = Rack::Utils.parse_query(request.query_string)

    selected_type       = type[request_query['by_type'].to_i]
    selected_situation  = situation[request_query['by_commercial'].to_i]
    selected_block      = request_query['by_block'].to_i

    response_query      = "situacao=#{selected_situation}" \
                          "&tipo=#{selected_type}" \
                          "&bloco=#{selected_block}" \
                          "&frame=true"

    "imoveis/listagem?#{response_query}"
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :advertisements, only: [:new, :create]

  resources :deliveries, path: :delivery, only: [:index], controller: 'markets' do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  resources :favorites, path: :favoritos, only: [:index, :create, :destroy]

  resources :markets, path: :comercio, only: [:index], controller: 'markets' do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  resources :messages, path: :mensagens, only: [:index, :new, :create]

  resources :properties, path: :imoveis, only: [:index] do
    get 'show', path: :detalhes
    collection { get 'list', path: :listagem }
  end

  # Admin resources
  scope :gestao, module: :admin, as: :admin do
    get '', to: 'dashboards#index'

    resources :customers, path: :clientes, shallow: true do
      collection { get 'add_contact_phone' }

      resources :markets, path: :comercio do
        resources :categories, path: :tipos, controller: 'markets/categories',
          only: [:index, :new, :create, :destroy]

        resources :specialities, path: :especialidades,
          controller: 'markets/specialities', only: [:new, :create, :destroy]
      end
    end

    resources :dashboards, only: [:index]

    resources :properties, path: :imoveis do
      resources :property_images, path: :imagens
    end

    resources :users, path: :usuarios do
      resources :roles, path: :permissoes,
        only: [:index, :new, :create, :destroy],
        controller: 'users/roles'
    end
  end # End admin resources
end
