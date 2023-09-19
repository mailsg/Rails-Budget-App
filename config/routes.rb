Rails.application.routes.draw do
  root to: "main#index", as: "root"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :main, only: [:index]
  resources :users
  resources :categories, only: [:index, :new, :create, :update, :show, :destroy] do
    resources :expenses, only: [:index, :new, :create, :destroy]
  end
end
