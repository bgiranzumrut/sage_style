Rails.application.routes.draw do
  devise_for :admins

  resources :products
  resources :categories

  namespace :admin do
    get "dashboard/index"
    get 'dashboard', to: 'dashboard#index'
    resources :products
    resources :categories
    root to: "dashboard#index"
  end

  # This line enables image URLs like /rails/active_storage/blobs/...
  mount ActiveStorage::Engine => '/rails/active_storage'

  root to: "welcome#index"
end
