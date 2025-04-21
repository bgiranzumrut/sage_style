Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  get "pages/about"
  get "pages/contact"
  get "/provinces/:id/tax_rates", to: "provinces#tax_rates"


  devise_for :admins
  ActiveAdmin.routes(self)  # Load ActiveAdmin resources (like PageContent)

  resources :products
  resources :categories
  resources :orders, only: [:new, :create, :show, :index]




  namespace :admin do
    get "dashboard/index"
    get 'dashboard', to: 'dashboard#index'
    resources :products
    resources :categories
    resources :categories, only: [:show]
  end

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'


get    '/cart',              to: 'cart#show',   as: 'cart'
post   '/cart/add/:id',      to: 'cart#add',    as: 'add_to_cart'
get    '/cart/remove/:id',   to: 'cart#remove', as: 'remove_from_cart'
post   '/cart/update',       to: 'cart#update', as: 'update_cart'
get  'payments/new',    to: 'payments#new'
post 'payments/charge', to: 'payments#charge'



  mount ActiveStorage::Engine => '/rails/active_storage'

  root to: "welcome#index"
end
