Rails.application.routes.draw do
  devise_for :users
  root to: 'tournaments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tournaments, only: [:index, :show]
  resources :teams, only: [:index, :show]
end
