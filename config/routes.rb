Rails.application.routes.draw do
  # Administração (admin.(url_do_site).com.br)
  constraints subdomain: 'admin' do
    namespace :admin do
      # Rotas para cadastro de Clients
      resources :clients, path: 'cadastro-clientes'
      resources :plans
      # Rotas para SystemAdmin (Somente SuperAdmins)
      resources :system_admins, path: 'cadastro-admin', except: [:show]
      # Rotas para relatórios
      resources :reports, only: [:index], path: 'relatorios'
    end
  end

  # searchs

  get '/contacts/search', to: 'contacts#search', as: :search_contacts

  # Sistema Principal ((url_do_site).com.br)

  # Comentando as rotas do Devise para desabilitar a autenticação
  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',  # Referencia ao controlador de registro customizado
  #   sessions: 'users/sessions'
  # }

  # Alterando a root para uma página pública sem autenticação
  root 'dashboard#index'

  # Comentando a rota de login não autenticado
  # unauthenticated do
  #   root 'devise/sessions#new', as: :unauthenticated_root
  # end

  # Dashboard
  resources :dashboard, only: [:index]

  # Cadastro geral de Companies, Groups e Contacts
  resources :companies, only: [:index, :edit, :create, :update, :destroy]
  resources :groups, only: [:index, :create, :update, :destroy]
  resources :contacts, only: [:index, :create, :update, :destroy]

  # Oportunidades (com suporte para lightbox)
  resources :opportunities, path: 'oportunidade', only: [:index, :show, :update, :new, :create, :edit]

  # Cadastro de Produtos e Marcas
  resources :client_products, path: 'produtos' do
    resources :product_brands, path: 'marcas'
  end

  # Configurações de conta (minha_conta)
  namespace :my_account do
    root 'settings#index'
    resources :usuarios, only: [:index, :edit, :update, :destroy]
  end

  # Cadastro (registrations) - Customized URL, if necessary in the future.
  # resources :registrations, only: [:new, :create], path: 'cadastro'

  # Rota para verificar saúde do sistema
  get 'up' => 'rails/health#show', as: :rails_health_check
end