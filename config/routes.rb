Rails.application.routes.draw do
  devise_for :admins

  # Temporary public access for development/testing
  resources :products
  resources :categories

  namespace :admin do
    get "dashboard/index"
    get 'dashboard', to: 'dashboard#index'
    resources :products
    resources :categories
    root to: "dashboard#index"
  end

  root to: "welcome#index"
end
