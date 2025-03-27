Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  get "pages/about"
  get "pages/contact"

  devise_for :admins
  ActiveAdmin.routes(self)  # ✅ Load ActiveAdmin resources (like PageContent)

  resources :products
  resources :categories

  namespace :admin do
    get "dashboard/index"
    get 'dashboard', to: 'dashboard#index'
    resources :products
    resources :categories
    resources :categories, only: [:show]
  end

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

  mount ActiveStorage::Engine => '/rails/active_storage'

  root to: "welcome#index"
end
