Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tournaments, only: [:show]
  resources :teams, only: [:index, :show]
  resources :abouts, only: [:index]
  resources :contacts, only: [:index, :new, :create]

  root to: 'tournaments#index'
end
