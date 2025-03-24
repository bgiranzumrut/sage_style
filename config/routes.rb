Rails.application.routes.draw do
  devise_for :admins
  # Devise routes for admin login
  #devise_for :admins

  # Admin namespace
  namespace :admin do
    get "dashboard/index"
    get 'dashboard', to: 'dashboard#index'
    resources :products
    resources :categories
    root to: "dashboard#index" # Optional: Admin root
  end

  # Root path for the main site
  root to: "welcome#index"
end
